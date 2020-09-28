import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import "controls" as Controls

ApplicationWindow {
    id: mainWindow
    visible: true

    width: Qt.platform.os == "android" ? Screen.width : 1024
    height: Qt.platform.os == "android" ? Screen.height : 720
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint

    Rectangle {
        id: titleBar
        width: parent.width; height: 65
        color: "#424242"

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property point clickPos: "0,0"
            onPressed: clickPos = Qt.point(mouse.x,mouse.y)
            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                mainWindow.setX(mainWindow.x+delta.x)
                mainWindow.setY(mainWindow.y+delta.y)
            }
            onDoubleClicked: doScreenChanged()
        }

        ListView {
            id: activeTitleBar
            height: parent.height
            readonly property real validWidth: parent.width - staticTitleBar.width
            width: count*85 > validWidth ? validWidth : count*85

            orientation: ListView.Horizontal
            clip: true

            Container {
                id: activeTitleBarContainer
                Controls.TabButton {
                    index: 0; closeEnabled: false
                    iconSource: "qrc:/pic/HomePage/Home.png"
                    onClicked: activeTitleBar.currentIndex = index
                }
            }

            model: activeTitleBarContainer.contentModel

            highlight: Rectangle { color: "transparent"; border.color: "lightblue" }
        }

        Row {
            id: staticTitleBar
            anchors { top: parent.top; topMargin: 15; right: parent.right; rightMargin: 20 }
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Controls.PicButton {
                width: 20; height: 20
                iconSource: "qrc:/pic/small/CloseTransparent.png"
                color: entered ? "red" : "transparent"
                onClicked: Qt.quit()
            }

            Controls.PicButton {
                id: maxminButton
                width: 20; height: 20
                iconSource: "qrc:/pic/small/MaxTransparent.png"
                color: entered ? "deepskyblue" : "transparent"
                onClicked: doScreenChanged()
            }

            Controls.PicButton {
                width: 20; height: 20
                iconSource: "qrc:/pic/small/MinTransparent.png"
                color: entered ? "deepskyblue" : "transparent"
                onClicked: mainWindow.visibility = Window.Minimized
            }
        }
    }

    SwipeView {
        id: swipeView
        currentIndex: activeTitleBar.currentIndex
        anchors { top: titleBar.bottom; left: parent.left }
        width: parent.width; height: parent.height - titleBar.height

        interactive: false
        background: Rectangle {
            color: "lightgrey"
        }

        HomePage {
        }
    }

    function doScreenChanged() {
        if (mainWindow.visibility === Window.Windowed) {
            mainWindow.visibility = Window.FullScreen
            maxminButton.iconSource = "qrc:/pic/small/ReductionTransparent.png"
        } else {
            mainWindow.visibility = Window.Windowed
            maxminButton.iconSource = "qrc:/pic/small/MaxTransparent.png"
        }
    }
}
