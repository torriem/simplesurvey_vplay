import VPlayApps 1.0
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: survey_page
    backgroundColor: Theme.secondaryBackgroundColor

    AppFlickable {
        contentWidth: survey_page.width
        contentHeight: survey_column.height
        anchors.fill: parent

    Column {
        id: survey_column
        //anchors.fill: parent
        width: survey_page.width
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        spacing: dp(20)
        bottomPadding: dp(20)

        Rectangle {
            id: current_gps_source_rect
            visible: false
            width: parent.width
            height: gps_source_text.height + dp(20)
            //height: 300
            //border.width: 1
            //border.color: Theme.colors.dividerColor
            color: Theme.colors.backgroundColor


            //radius: dp(5)

            AppText {
                anchors.margins: dp(10)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                id: gps_source_text
                text: "<b>" + qsTr("GPS Source:") + "</b> " + ourPosition.name + ", " + ourPosition.nmeaSource+ ", " + ourPosition.supportedPositioningMethods
            }
        }
        DropShadow {
            source: current_gps_source_rect
            horizontalOffset: dp(3)
            verticalOffset: dp(3)
            samples: 17
            radius: dp(8.0)
            Layout.fillWidth: true
            color: "#80000000"
            width: parent.width
            height: current_gps_source_rect.height
        }


        Rectangle {
            id: current_gps_rect
            visible: false
            width: parent.width
            height: gps_grid.height + dp(20)
            //height: 300
            //border.width: 1
            //border.color: Theme.colors.dividerColor
            color: Theme.colors.backgroundColor

            //radius: dp(5)

            GridLayout{
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.left: parent.left
                anchors.leftMargin: dp(10)
                anchors.top: parent.top
                anchors.topMargin: dp(10)


                id: gps_grid
                columnSpacing: dp(4)
                rowSpacing: dp(4)
                columns: 4
                Layout.fillWidth: true

                AppText {
                    text: qsTr("Current GPS Position")
                    color: Theme.tintColor
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.columnSpan: 4
                }

                AppText {
                    text: qsTr("Lat:")
                    font.bold: true
                }

                AppText {
                    id: gps_latitude
                    text: latitude === undefined ? "<i>unknown</i>" : latitude.toFixed(7) + qsTr("\u00b0")
                }

                AppText {
                    text: qsTr("Alt:")
                    font.bold: true
                }

                AppText {
                    id: gps_altitude
                    text: altitude === undefined ? "<i>unknown</i>" : altitude.toFixed(2) + " " + qsTr("m");
                }

                AppText {
                    text: qsTr("Long:")
                    font.bold: true
                }

                AppText {
                    id: gps_longitude
                    text: longitude === undefined ? "<i>unknown</i>" : longitude.toFixed(7) + qsTr("\u00b0")
                }

                AppText {
                    text: qsTr("Head:")
                    font.bold: true
                }

                AppText {
                    text: heading === undefined? "<i>unknown</i>" : heading.toFixed(1) + " " + qsTr("\u00b0")
                }

                AppText {
                    text: qsTr("H Acc:")
                    font.bold: true
                }

                AppText {
                    text: horiz_acc === undefined ? "" : horiz_acc.toFixed(1) + " " + qsTr("cm")
                }

                AppText {
                    text: qsTr("V Acc:")
                    font.bold: true
                }

                AppText {
                    text: vert_acc === undefined ? "" : vert_acc.toFixed(1) + " " + qsTr("cm")
                }
            }
        }
        DropShadow {
            source: current_gps_rect
            horizontalOffset: dp(3)
            verticalOffset: dp(3)
            samples: 17
            radius: dp(8.0)
            Layout.fillWidth: true
            color: "#80000000"
            width: parent.width
            height: gps_grid.height + dp(20)
        }
        Rectangle {
            id: start_gps_rect
            visible: false
            width: parent.width
            height: start_gps_grid.height + dp(20)
            //height: 300
            //border.width: 1
            //border.color: Theme.colors.dividerColor
            color: Theme.colors.backgroundColor

            //radius: dp(5)

            GridLayout{
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.left: parent.left
                anchors.leftMargin: dp(10)
                anchors.top: parent.top
                anchors.topMargin: dp(10)


                id: start_gps_grid
                columnSpacing: dp(4)
                rowSpacing: dp(4)
                columns: 4
                Layout.fillWidth: true

                AppText {
                    text: qsTr("From Start")
                    color: Theme.tintColor
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.columnSpan: 4
                }

                AppText {
                    text: qsTr("North:")
                    font.bold: true
                }

                AppText {
                    text: northing === undefined ? "" : northing.toFixed(2) + " " + qsTr("m");
                }

                AppText {
                    text: qsTr("Elevation:")
                    font.bold: true
                }

                AppText {
                    text: altitude === undefined? "" : altitude.toFixed(3) + " " + qsTr("m");
                }

                AppText {
                    text: qsTr("East:")
                    font.bold: true
                }

                AppText {
                    text: easting === undefined ? "" : easting.toFixed(2) + " " + qsTr("m");
                }

                AppText {
                    text: qsTr("Bearing:")
                    font.bold: true
                }

                AppText {
                    text: heading===undefined ? "" : heading.toFixed(1) + " " + qsTr("\u00b0")
                }
            }
        }
        DropShadow {
            source: start_gps_rect
            horizontalOffset: dp(3)
            verticalOffset: dp(3)
            samples: 17
            radius: dp(8.0)
            Layout.fillWidth: true
            color: "#80000000"
            width: parent.width
            height: start_gps_grid.height + dp(20)
        }

        Rectangle {
            id: mark_gps_rect
            visible: false
            width: parent.width
            height: mark_gps_grid.height + dp(20)
            //height: 300
            //border.width: 1
            //border.color: Theme.colors.dividerColor
            color: Theme.colors.backgroundColor

            //radius: dp(5)

            GridLayout{
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.left: parent.left
                anchors.leftMargin: dp(10)
                anchors.top: parent.top
                anchors.topMargin: dp(10)


                id: mark_gps_grid
                columnSpacing: dp(4)
                rowSpacing: dp(4)
                columns: 4
                Layout.fillWidth: true

                AppText {
                    text: qsTr("From Mark")
                    color: Theme.tintColor
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.columnSpan: 4
                }

                AppText {
                    text: qsTr("North:")
                    font.bold: true
                }

                AppText {
                    text: ""
                }

                AppText {
                    text: qsTr("Elevation:")
                    font.bold: true
                }

                AppText {
                    text: altitude===undefined ? "" : altitude.toFixed(3) + " " + qsTr("m");
                }

                AppText {
                    text: qsTr("East:")
                    font.bold: true
                }

                AppText {
                    text: ""
                }

                AppText {
                    text: qsTr("Bearing:")
                    font.bold: true
                }

                AppText {
                    text: heading===undefined? "" : heading.toFixed(1) + " " + qsTr("\u00b0")
                }
            }
        }
        DropShadow {
            source: mark_gps_rect
            horizontalOffset: dp(3)
            verticalOffset: dp(3)
            samples: 17
            radius: dp(8.0)
            Layout.fillWidth: true
            color: "#80000000"
            width: parent.width
            height: mark_gps_grid.height + dp(20)
        }


        Row {
            //Layout.alignment: Qt.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: dp(5)
            height: children.height + dp(10)

            AppButton {
                id: start_button
                text: "Start"
                property bool reset: false
                enabled: (latitude !== undefined &&
                          longitude !== undefined) ? true : false

                onClicked: {
                    if (reset) {
                        text = qsTr("Start")
                        reset = false
                        mark_button.enabled = false
                    } else {
                        utm_pseudo_zone = longitude

                        text = qsTr("Reset")
                        reset = true
                        mark_button.enabled = true
                    }

                }
            }
            AppButton {
                id: mark_button
                text: "Mark"
                enabled: false
            }
        }
    }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
