import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.8
import QtLocation 5.9

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
    property real altitude: 0.0
    property real heading: 0.0
    property var horiz_acc: undefined
    property real vert_acc: 0.0

    property Position ourPos


    PositionSource {
        id: ourPosition
        nmeaSource: "socket://ltfrover:9001"
        active: true
        onPositionChanged: {
            ourPos = position

            if (! isNaN(position.coordinate.latitude)) {
                latitude = (position.coordinate.latitude).toFixed(7);
            } else {
                latitude = undefined;
            }

            if (! isNaN(position.coordinate.longitude)) {
                longitude = (position.coordinate.longitude).toFixed(7);
            } else {
                longitude = undefined;
            }

            if (! isNaN(position.coordinate.altitude)) {
                altitude = position.coordinate.altitude;
            }

            if (position.directionValid) {
                heading = position.direction;
            }

            if (position.horizontalAccuracyValid) {
                var _horiz_acc = position.horizontalAccuracy * 100;
                horiz_acc = _horiz_acc.toFixed(1)
            }

            if (position.verticalAccuracyValid) {
                vert_acc = (position.verticalAccuracy * 100).toFixed(1);
            }
        }
    }

    Navigation {

        // Comment to use a navigation drawer instead of tabs on Android
        navigationMode: navigationModeTabs

        NavigationItem {
            title: qsTr("Survey")
            icon: IconType.compass

            MainPage {}
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
