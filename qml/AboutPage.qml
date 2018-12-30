import VPlayApps 1.0
import QtQuick 2.0

Page {
    title: qsTr("About")

    AppFlickable {
        contentWidth: parent.width
        contentHeight: about_column.height + dp(40)
        anchors.fill: parent

        Column {
            id: about_column
            width: parent.width - dp(40)
            height: children.height
            y: dp(20)
            spacing: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            AppText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<b>" + qsTr("Simple Survey") + "</b>"
            }
            AppText {
                width: parent.width
                wrapMode: Text.WordWrap

                text: qsTr("This app is a simple tool for doing basic survey measuring.  Think of it like a virtual tape measure.  Once a starting position is marked, as you move the device or GPS receiver, a constant readout of distance in north/south and east/west components is provided, along with height difference, the resulting slope, and the bearing and total distance. If your GPS source is an RTK receiver, you can obtain accuracies of about 1 cm in each of the three dimensions.")
            }

            AppText {
                width: parent.width
                wrapMode: Text.WordWrap
                text: qsTr("This app can use either the device's built-in GPS for location, or can connect over wifi to an external GPS source provided over a TCP/IP connection, such as what a Reach RS unit provides.  Alternatively you can use <a href=\"https://play.google.com/store/apps/details?id=com.lefebure.ntripclient\">Lefebure NTRIP Client</a> to make an external GPS source available to the native Android location services. Connecting to a bluetooth GPS source is not yet supported.")
            }
        }
    }
}
