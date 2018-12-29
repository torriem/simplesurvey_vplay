import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.8
import QtLocation 5.9
import VPlay 2.0
import "utm.js" as Utm

App {
    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"
    id: mainApp

    property var latitude: undefined
    property var longitude: undefined
    property var altitude: undefined
    property var heading: undefined
    property var horiz_acc: undefined
    property var vert_acc: undefined
    property var easting: undefined
    property var northing: undefined
    property var utm_pseudo_zone: undefined
    property var start_north: undefined
    property var start_east: undefined
    property real start_altitude: 0.0
    property var mark_north: undefined
    property var mark_east: undefined
    property real mark_altitude: 0.0

    property bool distance_3d: false
    property bool use_inches: false


    property Position ourPos

    Storage {
        id: config
        Component.onCompleted:  {
            var v = config.getValue("dist3d")
            if (v == undefined) {
                distance_3d = false;
            } else {
                distance_3d = v;
            }

            v = config.getValue("use_inches")
            if (v == undefined) {
                use_inches = false;
            } else {
                use_inches = v;
            }
        }
    }

    PositionSource {
        id: ourPosition
        nmeaSource: "socket://ltfrover:9001"
        active: true
        onPositionChanged: {
            ourPos = position

            if (! isNaN(position.coordinate.latitude)) {
                latitude = position.coordinate.latitude;
            } else {
                latitude = undefined;
            }

            if (! isNaN(position.coordinate.longitude)) {
                longitude = position.coordinate.longitude;
            } else {
                longitude = undefined;
            }

            if (latitude !== undefined && longitude) {
                var t;

                if (utm_pseudo_zone !== undefined) {
                    t = Utm.from_latlon(latitude,longitude,utm_pseudo_zone)
                } else {
                    t = Utm.from_latlon(latitude,longitude,longitude)
                }
                easting = t.easting
                northing = t.northing
            }

            if (! isNaN(position.coordinate.altitude)) {
                altitude = position.coordinate.altitude;
            }

            if (position.directionValid) {
                heading = position.direction;
            } else {
                heading = undefined;
            }

            if (position.horizontalAccuracyValid) {
                horiz_acc = position.horizontalAccuracy * 100;
            } else {
                horiz_acc = undefined;
            }

            if (position.verticalAccuracyValid) {
                vert_acc = position.verticalAccuracy * 100;
            } else {
                vert_acc = undefined;
            }
        }
    }

    Navigation {

        // Comment to use a navigation drawer instead of tabs on Android
        navigationMode: navigationModeTabs

        NavigationItem {
            title: qsTr("Survey")
            icon: IconType.compass

            /*
            AppFlickable {
            anchors.fill: parent
            contentWidth: survey_page.width
            contentHeight: survey_page.height
*/
                MainPage {
                    id: survey_page
                }
            //}
        }
        NavigationItem {
            title: qsTr("Settings")
            icon: IconType.gears
            SettingsPage {}
        }
        NavigationItem {
            title: qsTr("About")
            icon: IconType.info
            AboutPage {}
        }

    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
