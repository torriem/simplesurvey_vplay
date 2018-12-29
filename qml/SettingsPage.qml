import VPlayApps 1.0
import QtQuick 2.0

Page {
    title: "Settings"

    Column {
        width: parent.width - dp(20)
        y: dp(10)
        spacing: dp(20)
        anchors.horizontalCenter: parent.horizontalCenter
        AppText {
            text: qsTr("<b>General Settings</b>")
            color: Theme.tintColor
            fontSize: 18
        }

        Column {
            width: parent.width - dp(20)
            spacing: dp(5)
            anchors.horizontalCenter: parent.horizontalCenter

            ExpandingRow2 {
                AppText {
                    text: qsTr("Use inches")
                    elide: Text.ElideLeft
                    color: Theme.textColor
                }
                AppSwitch {
                    id: metric_switch
                    checked: use_inches
                    onToggled: {
                        config.setValue("use_inches",checked)
                    }
                }

            }

            AppText {
                width: parent.width
                text: qsTr("Uses inches as the distance unit instead of metres");
                wrapMode: Text.WordWrap
                color: Theme.secondaryTextColor
            }


            Rectangle {
                width: parent.width
                height: px(1)
                color: Theme.dividerColor
            }

            Row {
                //width: parent.width
                id: row1
                width: parent.width

                function __update() {
                    var field1 = children[0];
                    field1.width = row1.width - children[1].width
                }

                onChildrenChanged: __update()
                onVisibleChanged: __update()
                onWidthChanged: __update()

                AppText {
                    text: qsTr("3D Distance")
                    elide: Text.ElideLeft
                    color: Theme.textColor

                }
                AppSwitch {
                    id: dist_3d_switch
                    checked: distance_3d
                    onToggled: {
                        distance_3d = checked
                        config.setValue("dist3d",checked)
                    }
                }
            }
            AppText {
                width: parent.width
                text: qsTr("If 3D Distance is on, distance calulations will also include the height. Otherwise it will only account for flat distance.")
                wrapMode: Text.WordWrap
                color: Theme.secondaryTextColor
            }

        }
        AppText {
            text: qsTr("<b>GPS Source</b>")
            color: Theme.tintColor
            fontSize: 18
        }

        Column {
            width: parent.width - dp(20)
            spacing: dp(5)
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
