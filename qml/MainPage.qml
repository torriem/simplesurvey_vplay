import VPlayApps 1.0
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "utm.js" as Utm
import "util.js" as Ssu

Page {
    id: survey_page
    backgroundColor: Theme.secondaryBackgroundColor
    title: qsTr("Survey")

    AppFlickable {
        contentWidth: survey_page.width
        contentHeight: survey_column.height + dp(20)
        anchors.fill: parent

        Column {
            id: survey_column
            //anchors.fill: parent
            y: spacing
            width: parent.width - spacing * 2
            spacing: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter

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
                    text: "<b>" + qsTr("GPS Source:") + "</b> " + ourPosition.name + " " + ourPosition.nmeaSource
                }
            }
            DropShadow {
                id: current_gps_source
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
                        text: latitude === undefined ? "<i>"+ qsTr("unknown") + "</i>" : latitude.toFixed(7) + qsTr("\u00b0")
                    }

                    AppText {
                        text: qsTr("Alt:")
                        font.bold: true
                    }

                    AppText {
                        id: gps_altitude
                        text: altitude === undefined ? "<i>" + qsTr("unknown") + "</i>" : Ssu.convert(altitude, use_inches)
                    }

                    AppText {
                        text: qsTr("Long:")
                        font.bold: true
                    }

                    AppText {
                        id: gps_longitude
                        text: longitude === undefined ? "<i>" + qsTr("unknown") + "</i>" : longitude.toFixed(7) + qsTr("\u00b0")
                    }

                    AppText {
                        text: qsTr("Head:")
                        font.bold: true
                    }

                    AppText {
                        text: heading === undefined? "<i>" + qsTr("unknown") + "</i>" : heading.toFixed(1) + " " + qsTr("\u00b0")
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
                        text: start_north === undefined ? "" : Ssu.convert(northing - start_north, use_inches);
                    }

                    AppText {
                        text: qsTr("Elevation:")
                        font.bold: true
                    }

                    AppText {
                        text: start_north === undefined? "" : Ssu.convert(altitude - start_altitude, use_inches)
                    }

                    AppText {
                        text: qsTr("East:")
                        font.bold: true
                    }

                    AppText {
                        text: start_east === undefined ? "" : Ssu.convert(easting - start_east, use_inches)
                    }

                    AppText {
                        text: qsTr("Bearing:")
                        font.bold: true
                    }

                    AppText {
                        text: start_north === undefined ? "" : (Math.atan2(easting - start_east, northing - start_north)).toFixed(1) + " " + qsTr("\u00b0")
                    }

                    AppText {
                        text: distance_3d ? qsTr("Dist 3D:") : qsTr("Dist:")
                        font.bold: true
                    }

                    AppText {
                        //Should we take elevation changes into account when doing distance?
                        text: start_north !== undefined ?
                                  ( distance_3d ? Ssu.convert(Ssu.distance3d( easting - start_east,
                                                                 northing - start_north,
                                                                 altitude - start_altitude), use_inches)
                                                : Ssu.convert(Ssu.distance2d( easting - start_east,
                                                                  northing - start_north), use_inches)
                                   )
                                : ""
                    }

                    AppText {
                        text: qsTr("Slope:")
                        font.bold: true
                    }

                    AppText {
                        text: start_north !== undefined ? (Ssu.slope_percent( easting - start_east,
                                                                             northing - start_north,
                                                                             altitude - start_altitude) * 100.0
                                                           ).toFixed(1) + qsTr("%")+ " " + qsTr("or") + " " +
                                                          (Ssu.slope_angle(easting - start_east,
                                                                           northing - start_north,
                                                                           altitude - start_altitude)
                                                           ).toFixed(0) + qsTr("\u00b0") : ""
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
                        text: mark_north === undefined ? "" : Ssu.convert(northing - mark_north, use_inches)
                    }

                    AppText {
                        text: qsTr("Elevation:")
                        font.bold: true
                    }

                    AppText {
                        text: mark_north === undefined? "" : Ssu.convert(altitude - mark_altitude, use_inches)
                    }

                    AppText {
                        text: qsTr("East:")
                        font.bold: true
                    }

                    AppText {
                        text: mark_east === undefined ? "" : Ssu.convert(easting - mark_east, use_inches)
                    }

                    AppText {
                        text: qsTr("Bearing:")
                        font.bold: true
                    }

                    AppText {
                        text: mark_north === undefined ? "" : (Math.atan2(easting - mark_east, northing - mark_north)).toFixed(1) + " " + qsTr("\u00b0")
                    }

                    AppText {
                        text: distance_3d ? qsTr("Dist 3D:") : qsTr("Dist:")
                        font.bold: true
                    }

                    AppText {
                        //Should we take elevation changes into account when doing distance?
                        text: mark_north !== undefined ?
                                  ( distance_3d ? Ssu.convert(Ssu.distance3d( easting - mark_east,
                                                                 northing - mark_north,
                                                                 altitude - mark_altitude), use_inches)
                                                : Ssu.convert(Ssu.distance2d( easting - mark_east,
                                                                  northing - mark_north), use_inches)
                                   )
                                : ""
                    }

                    AppText {
                        text: qsTr("Slope:")
                        font.bold: true
                    }

                    AppText {
                        text: mark_north !== undefined ? (Ssu.slope_percent( easting - mark_east,
                                                                             northing - mark_north,
                                                                             altitude - mark_altitude) * 100.0
                                                           ).toFixed(1) + qsTr("%")+ " " + qsTr("or") + " " +
                                                          (Ssu.slope_angle(easting - mark_east,
                                                                           northing - mark_north,
                                                                           altitude - mark_altitude)
                                                           ).toFixed(0) + qsTr("\u00b0") : ""
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
                            pause_button.enabled = false
                            start_north = undefined
                            start_east = undefined
                            mark_north = undefined
                            mark_east = undefined
                            ourPosition.start()
                            pause_button.text = qsTr("Pause")

                        } else {
                            //Press start
                            utm_pseudo_zone = longitude
                            var c = Utm.from_latlon(latitude,longitude,utm_pseudo_zone)
                            start_east = c.easting
                            start_north = c.northing
                            start_altitude = altitude

                            text = qsTr("Reset")
                            reset = true
                            mark_button.enabled = true
                            pause_button.enabled = true
                        }

                    }
                }
                AppButton {
                    id: mark_button
                    text: qsTr("Mark")
                    enabled: false
                    onClicked: {
                        mark_east = easting
                        mark_north = northing
                        mark_altitude = altitude
                    }
                }
                AppButton {
                    id: pause_button
                    text: qsTr("Pause")
                    enabled: false
                    property bool paused: false

                    onClicked: {
                        if (paused) {
                            ourPosition.start()
                            text = qsTr("Pause")
                        } else {
                            ourPosition.stop()
                            text = qsTr("Resume")
                        }

                        paused = !paused
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
