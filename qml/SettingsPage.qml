import VPlayApps 1.0
import QtQuick 2.0

Page {
    id: settings_page
    title: "Settings"

    AppFlickable {
        contentWidth: parent.width
        contentHeight: settings_column.height + dp(20)
        anchors.fill: parent

        Column {
            id: settings_column
            width: parent.width - dp(20)
            y: dp(10)
            spacing: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            AppText {
                text: "<b>" + qsTr("General Settings") + "</b>"
                color: Theme.tintColor
                fontSize: 18
            }

            Column {
                width: parent.width - dp(20)
                spacing: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter

                ExpandingRow2 {
                    AppText {
                        text: "<b>" + qsTr("Use inches") + "</b>"
                        elide: Text.ElideLeft
                        color: Theme.textColor
                    }
                    AppSwitch {
                        id: metric_switch
                        checked: use_inches
                        onToggled: {
                            app.settings.setValue("use_inches",checked)
                            use_inches = checked
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
                    height: dp(1)
                    color: Theme.dividerColor
                }

                ExpandingRow2 {
                    //width: parent.width
                    width: parent.width

                    AppText {
                        text: "<b>" + qsTr("3D Distance") + "</b>"
                        elide: Text.ElideLeft
                        color: Theme.textColor

                    }
                    AppSwitch {
                        id: dist_3d_switch
                        checked: distance_3d
                        onToggled: {
                            distance_3d = checked
                            app.settings.setValue("dist3d",checked)
                            //nativeUtils.displayMessageBox("Help!","Please help me!",1)
                        }
                    }
                }
                AppText {
                    width: parent.width
                    text: qsTr("If 3D Distance is on, distance calulations will also include the height. Otherwise it will only account for flat distance.")
                    wrapMode: Text.WordWrap
                    color: Theme.secondaryTextColor
                }
                Rectangle {
                    width: parent.width
                    height: dp(1)
                    color: Theme.dividerColor
                }

            }
            AppText {
                text: "<b>" + qsTr("GPS Source") + "</b>"
                color: Theme.tintColor
                fontSize: 18
            }

            Column {
                width: parent.width - dp(20)
                spacing: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter

                AppText {
                    width: parent.width
                    text: qsTr("Normally this app uses the built-in GPS receiver. You can enable an external TCP NMEA source here.");
                    wrapMode: Text.WordWrap
                    color: Theme.secondaryTextColor
                }

                Rectangle {
                    width: parent.width
                    height: dp(1)
                    color: Theme.dividerColor
                }

                AppText {
                    text: "<b>" + qsTr("NMEA TCP Server") + "</b>"
                    color: Theme.textColor
                }

                //TODO: need better way to record the changes
                //      and if the server is already enabled,
                //      change the url parameters
                AppTextField {
                    width: parent.width
                    placeholderText: qsTr("Hostname or IP Address")
                    text: tcp_hostname !== undefined? tcp_hostname : ""
                    id: hostname

                    onEditingFinished: {
                        tcp_hostname = text
                        app.settings.setValue("tcp_hostname",text)
                    }
                    onActiveFocusChanged: {
                        console.log("focus changed.")
                    }
                 }

                AppText {
                    text: "<b>" + qsTr("Port") + "</b>"
                }

                AppTextField {
                    placeholderText: qsTr("Port number")
                    id: portnumber
                    text: tcp_port !== undefined ? tcp_port : ""
                    validator: IntValidator {bottom: 0; top: 65535}
                    inputMethodHints: Qt.ImhDigitsOnly
                    onEditingFinished: {
                        tcp_port = text
                        app.settings.setValue("tcp_port",text)
                    }
                    onActiveFocusChanged: {
                        console.log("focus changed.")
                    }

                }
                Rectangle {
                    width: parent.width
                    height: dp(1)
                    color: Theme.dividerColor
                }

                ExpandingRow2 {
                    AppText {
                        text: "<b>" + qsTr("Use NMEA TCP Server") + "</b>"
                        color: Theme.textColor
                    }
                    AppSwitch {
                        id: use_tcp_switch
                        checked: use_tcp
                        enabled: (hostname.text.length > 0 && portnumber.text.length >0)
                        onToggled: {
                            if (checked) {
                                //record the hostname and port fields
                                tcp_port = portnumber.text
                                app.settings.setValue("tcp_port",tcp_port)
                                tcp_hostname = hostname.text
                                app.settings.setValue("tcp_hostname",tcp_hostname)

                                if (tcp_hostname != "" &&
                                    tcp_port != "" ) {
                                    var url = "socket://"+tcp_hostname+":"+tcp_port
                                    ourPosition.nmeaSource = url
                                } else {
                                    checked = false;
                                }
                            } else {
                                //ourPosition.nmeaSource = ""
                                nativeUtils.displayMessageBox("","Restart this app for this change to take effect.",1)
                            }

                            app.settings.setValue("use_tcp",checked)

                        }
                    }

                }


            }
        }
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
