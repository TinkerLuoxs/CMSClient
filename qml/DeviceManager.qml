import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "controls" as Controls

CommonPage {
    Row {
        id: buttonSet
        x: 16; y: 8
        spacing: 8

        Controls.PureButton {
            text: qsTr("Search")
            onClicked: popupDeviceSearch.open()
        }
        Controls.PureButton {
            text: qsTr("Add")
            onClicked: popupDeviceAdd.open()
        }
    }

    Popup {
        id: popupDeviceSearch

        x: buttonSet.x; y: buttonSet.y
        width: 640; height: 480
        closePolicy: Popup.NoAutoClose

        Controls.TableView {
            id: listDevice
            width: parent.width
            height: parent.height - 48

            header: [
                Controls.TableElement {
                    role: "name"
                    title: qsTr("name")
                },
                Controls.TableElement {
                    role: "ip"
                    title: qsTr("ip")
                },
                Controls.TableElement {
                    role: "port"
                    title: qsTr("port")
                },
                Controls.TableElement {
                    role: "type"
                    title: qsTr("type")
                },
                Controls.TableElement {
                    role: "streamType"
                    title: qsTr("stream type")
                }
            ]
        }

        Row {
            anchors {
                bottom: parent.bottom; bottomMargin: 8
                right: parent.right; rightMargin: 16
            }
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Controls.PureButton {
                text: qsTr("Cancel")
                onClicked: popupDeviceSearch.close()
            }
            Controls.PureButton {
                text: qsTr("Search")
            }
        }
    }

    Popup {
        id: popupDeviceAdd

        x: buttonSet.x; y: buttonSet.y
        width: 480; height: 360
        closePolicy: Popup.NoAutoClose

        GroupBox {
            id: content
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: 300

            title: qsTr("Add Device")
            GridLayout {
                columns: 2
                columnSpacing: 18
                rowSpacing: 10

                Controls.Text { text: qsTr("Device Name") }
                Controls.TextField {}

                Controls.Text { text: qsTr("IP") }
                Controls.TextField {}

                Controls.Text { text: qsTr("Port") }
                Controls.TextField {}

                Controls.Text { text: qsTr("Machine Type") }
                Controls.ComboBox {
                    model: [qsTr("Ball Machine"), qsTr("Hemisphere Machine"), qsTr("Bolt Machine")]
                }

                Controls.Text { text: qsTr("Stream Type") }
                Controls.ComboBox {
                    model: [qsTr("Main-stream"), qsTr("Sub-stream"), qsTr("Third-stream")]
                }

                Controls.Text { text: qsTr("Username") }
                Controls.TextField {}

                Controls.Text { text: qsTr("Password") }
                Controls.TextField {}
            }
        }

        Row {
            anchors {
                top: content.bottom
                topMargin: 16
                left: parent.left
            }
            width: parent.width
            height: parent.height - content.height
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Controls.PureButton {
                text: qsTr("Cancel")
                onClicked: popupDeviceAdd.close()
            }
            Controls.PureButton {
                text: qsTr("Add")
            }
        }
    }

    Controls.TableView {
        anchors {
            top: buttonSet.bottom; topMargin: 8
            left: parent.left; leftMargin: 8
            bottom: parent.bottom
        }
        width: parent.width - 100

        header: [
            Controls.TableElement {
                role: "sequence"
                title: qsTr("sequence")
            },
            Controls.TableElement {
                role: "name"
                title: qsTr("name")
            },
            Controls.TableElement {
                role: "ip"
                title: qsTr("ip")
                width: 200
            },
            Controls.TableElement {
                role: "type"
                title: qsTr("type")
            },
            Controls.TableElement {
                role: "streamType"
                title: qsTr("stream type")
            },
            Controls.TableElement {
                role: "port"
                title: qsTr("port")
            },
            Controls.TableElement {
                role: "username"
                title: qsTr("username")
                width: 200
            },
            Controls.TableElement {
                role: "password"
                title: qsTr("password")
            }
        ]

        orderByColumn: true
        model: ListModel {
            ListElement {
                sequence: 1
                name: "jack"
                ip: "127.0.0.1"
                type: 2
                streamType: 0
                port: 8000
                username: "admin"
                password: "admin"
            }
            ListElement {
                sequence: 1
                name: "lucy"
                ip: "192.168.0.1"
                type: 1
                streamType: 0
                port: 7000
                username: "admin"
                password: "admin"
            }
        }
    }


}
