import VPlayApps 1.0
import QtQuick 2.0

Page {
    title: "About"

    Column {
        width: parent.width - dp(20)
        height: children.height
        y: dp(10)
        anchors.horizontalCenter: parent.horizontalCenter
        AppText {
            width: parent
            anchors.margins: dp(20)
            text: "<b>Simple Survey</b>"
        }
    }
}
