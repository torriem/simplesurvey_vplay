import VPlayApps 1.0
import QtQuick 2.0

Page {
    title: "Settings"

    Column {
        width: parent.width - spacing/2
        spacing: dp(20)
        y: spacing / 2
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            width: parent.width
            height: px(1)
            color: Theme.dividerColor
        }

    }

}
