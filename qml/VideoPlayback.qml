import QtQuick 2.8
import QtQuick.Controls 2.2
import "controls" as Controls

CommonPage {
    Controls.SplitView {
        id: videoPlayPage
        width: parent.width - deviceListPage.width
        height: parent.height - controlPage.height

        model: [2, 2, 4]

        Controls.SplitELement {}
        Controls.SplitELement {}
        Controls.SplitELement {}
        Controls.SplitELement {}
    }

    Column {
        id: popupToolBox
        z: 1000

        readonly property real maxHeight: videoPlayPage.height + popupButton.height
        property bool poppedUp: false
        y: poppedUp ? maxHeight - height + popupButton.height : maxHeight
        x: videoPlayPage.x + 16

        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/ThirtySix2.png" : "qrc:/pic/PlayScreen/ThirtySix.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [6, 6, 36]
                videoPlayPage.resetData(36)
                videoPlayPage.updateData()               
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/TwentyFive2.png" : "qrc:/pic/PlayScreen/TwentyFive.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [5, 5, 25]
                videoPlayPage.resetData(25)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Sixteen2.png" : "qrc:/pic/PlayScreen/Sixteen.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [4, 4, 16]
                videoPlayPage.resetData(16)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Nine2.png" : "qrc:/pic/PlayScreen/Nine.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [3, 3, 9]
                videoPlayPage.resetData(9)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Eight2.png" : "qrc:/pic/PlayScreen/Eight.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [4, 4, 8]
                videoPlayPage.resetData(8)
                videoPlayPage.setData(0, 3, 3)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Six2.png" : "qrc:/pic/PlayScreen/Six.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [3, 3, 6]
                videoPlayPage.resetData(6)
                videoPlayPage.setData(0, 2, 2)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Four2.png" : "qrc:/pic/PlayScreen/Four.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [2, 2, 4]
                videoPlayPage.resetData(4)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            visible: popupToolBox.poppedUp ? true : false
            iconSource: entered ? "qrc:/pic/PlayScreen/Single2.png" : "qrc:/pic/PlayScreen/Single.png"
            onClicked: {
                popupToolBox.poppedUp = !popupToolBox.poppedUp
                videoPlayPage.model = [1, 1, 1]
                videoPlayPage.resetData(1)
                videoPlayPage.updateData()
            }
        }
        Controls.PicButton {
            id: popupButton
            iconSource: "qrc:/pic/PlayScreen/Popup.png"
            color: entered ? "forestgreen" : "transparent"
            onClicked: popupToolBox.poppedUp = !popupToolBox.poppedUp
        }
    }

    Item {
        id: deviceListPage
        anchors.right: parent.right
        width: 220
        height: parent.height -controlPage.height

        Controls.TreeView {
            anchors.fill: parent
            title: qsTr("Device list")
        }
    }

    Item {
        id: controlPage
        anchors.bottom: parent.bottom
        width: parent.width - deviceListPage.width
        height: 200

        Row {
            id: playCtrl
            anchors {
                top: parent.top; topMargin: popupButton.height
                horizontalCenter: parent.horizontalCenter
            }

            spacing: 8
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayCtrl/Stop2.png" : "qrc:/pic/PlayCtrl/Stop.png"
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayCtrl/Backward2.png" : "qrc:/pic/PlayCtrl/Backward.png"
            }
            Text {
                text: "1X"
                height: parent.height
                font.family: "Consolas"
                font.pointSize: 10

                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayCtrl/Forward2.png" : "qrc:/pic/PlayCtrl/Forward.png"
            }
        }

        Slider {
            id: zoomTime
            anchors { bottom: parent.bottom; left: parent.left; leftMargin: 8}

            background: Rectangle {
                x: zoomTime.leftPadding
                y: zoomTime.topPadding + zoomTime.availableHeight / 2 - height / 2
                implicitWidth: 180
                implicitHeight: 4
                width: zoomTime.availableWidth
                height: implicitHeight
                radius: 2
                color: "#eeeeee"

                Rectangle {
                    width: zoomTime.visualPosition * parent.width
                    height: parent.height
                    color: "#21be2b"
                    radius: 2
                }
            }

            handle: Rectangle {
                x: zoomTime.leftPadding + zoomTime.visualPosition * (zoomTime.availableWidth - width)
                y: zoomTime.topPadding + zoomTime.availableHeight / 2 - height / 2
                implicitWidth: 16
                implicitHeight: 16
                radius: 13
                color: zoomTime.pressed ? "#8585ff" : "#f0f0f0"
                border.color: "#bdbebf"
            }
        }

        ScrollBar {
            id: hscrollbar
            x: zoomTime.x + 260; y: zoomTime.y + 6
            height: 16
            width: parent.width - 300

            size: 1.0
            active: true
            orientation: Qt.Horizontal

            background: Rectangle {
                color: "#eeeeee"
            }

            contentItem: Rectangle {
                radius: width / 2
                color: "#808080"
            }
        }

        ScrollBar {
            id: vscrollbar
            anchors { bottom: hscrollbar.top; left: hscrollbar.right}
            width: 16; height: 80

            size: 1.0
            active: true
            orientation: Qt.Vertical

            background: Rectangle {
                color: "#eeeeee"
            }

            contentItem: Rectangle {
                radius: height / 2
                color: "#808080"
            }
        }

        Item {
            id: zoomRoot
            anchors { left: parent.left; leftMargin: 4; right: vscrollbar.left; bottom: zoomTime.top }
            height: 100

            readonly property int visibleNumber: zoomTime.visualPosition > 0.7 ? 288
                                               : zoomTime.visualPosition > 0.5 ? 144
                                               : zoomTime.visualPosition > 0.3 ? 72
                                               : zoomTime.visualPosition > 0.1 ? 48
                                               : 24
            readonly property real zoomCellWidth: (scrollTime.width + zoomTime.visualPosition * 30000) / visibleNumber

            function timeFromInteger(mol,den,mul) {
                var textTime = ""
                var hour = Math.floor(mol / den)
                var min = mol % den * mul
                if (hour < 10)
                    textTime += 0
                textTime += hour
                textTime += ":"
                if (min < 10)
                    textTime += 0
                textTime += min
                return textTime
            }

            function displayTime(number) {
                switch (visibleNumber){
                case 24: return number;
                case 48: return timeFromInteger(number, 2, 30);
                case 72: return timeFromInteger(number, 3, 20);
                case 144: return timeFromInteger(number, 6, 10);
                case 288: return timeFromInteger(number, 12, 5);
                }
            }

            ListView {
                id: scrollWindow
                clip: true
                y: 20; width: parent.width; height: 80
                contentHeight: 720
                model: 36
                delegate: Rectangle {
                    width: scrollWindow.width; height: 20
                    color: "#333333"
                    border.color: "#fafafa"
                    Text {
                        text: qsTr("Play window " + (index + 1))
                        font.family: "Consolas"
                        color: "white"
                        anchors { left: parent.left; leftMargin: 4 }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ScrollBar.vertical: vscrollbar
            }

            ListView {
                id: scrollTime
                clip: true
                orientation: ListView.Horizontal
                anchors { left: parent.left; leftMargin: 120; right: parent.right }
                height: parent.height
                contentWidth: width + 30000
                model: zoomRoot.visibleNumber
                delegate: Item {
                    width: zoomRoot.zoomCellWidth; height: scrollTime.height

                    Text {
                        x: -parent.width/2;
                        width: parent.width; height: 20
                        text: index == 0 ? "" : zoomRoot.displayTime(index)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignBottom
                    }

                    Rectangle { y: 20; width: 1; height: scrollWindow.height; color: "white" }
                }

                interactive: false
                ScrollBar.horizontal: hscrollbar

                MouseArea {
                    anchors { top: parent.top; topMargin: 20; bottom: parent.bottom }
                    width: parent.width

                    hoverEnabled: true
                    onEntered: tag.visible = true
                    onExited: tag.visible = false

                    ToolTip {
                        id: tag
                        x: parent.mouseX + 10
                        y: parent.mouseY
                        text: {
                            var maxSize = scrollTime.width + zoomTime.visualPosition * 30000
                            var curSize = maxSize * hscrollbar.position + parent.mouseX
                            var second = Math.floor(curSize / maxSize * 86400)
                            var hour = Math.floor(second / 3600)
                            var min = Math.floor(second % 3600 / 60)
                            second = Math.floor(second % 60)
                            var textTime = ""
                            if (hour < 10) textTime += '0'
                            textTime += hour; textTime += ":"
                            if (min < 10) textTime += '0'
                            textTime += min; textTime += ":"
                            if (second < 10) textTime += '0'
                            textTime += second
                            textTime
                        }
                    }
                }
            }
        }
    }

    Item {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: deviceListPage.width
        height: controlPage.height

        Controls.Text {
            x: 4; y:8; width: 70; height: 28
            text: qsTr("RecordType")
        }
        Controls.ComboBox {
            x: 80; y:8; width: 135; height: 28
            model: [qsTr("All"), qsTr("General"), qsTr("Alarm")]
        }
        Controls.Text {
            x: 4; y:44; width: 70; height: 28
            text: qsTr("StreamType")
        }
        Controls.ComboBox {
            x: 80; y:44; width: 135; height: 28
            model: [qsTr("Main-stream"), qsTr("Sub-stream"), qsTr("Third-stream")]
        }
        Controls.Text {
            x: 4; y:80; width: 70; height: 28
            text: qsTr("StartTime")
        }
        TextField {
            x: 80; y:80; width: 135; height: 28
            text: new Date().toLocaleString(Qt.locale(), "yyyy-MM-dd 00:00:00")
        }
        Controls.Text {
            x: 4; y:116; width: 70; height: 28
            text: qsTr("EndTime")
        }
        TextField {
            x: 80; y:116; width: 135; height: 28
            text: new Date().toLocaleString(Qt.locale(), "yyyy-MM-dd 23:59:59")
        }
        Controls.PureButton {
            x: 80; y: 152; width: 135; height: 28
            text: qsTr("Search")
        }
    }
}
