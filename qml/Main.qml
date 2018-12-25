import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.8
import QtLocation 5.9
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
    property real start_north: 0.0
    property real start_east: 0.0
    property real start_altitude: 0.0



    property Position ourPos


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
            Page {}
        }
        NavigationItem {
            title: qsTr("About")
            icon: IconType.info
            Page {}
        }

    }
}
