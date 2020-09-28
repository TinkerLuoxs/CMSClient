import QtQuick 2.8

Rectangle {
    id: control

    property int cellRows: 1
    property int cellColumns: 1

    property int cellX: 0
    property int cellY: 0

    property var root
    property int index: -1

    x: root ? root.fullscreen ? root.index == index ? root.x : 0 : root.x + cellX * root.cellWidth : 0
    y: root ? root.fullscreen ? root.index == index ? root.y : 0 : root.y + cellY * root.cellHeight : 0
    z: root ? root.fullscreen ? root.index == index ? 0 : -1 : 0 : 0

    width: root ? root.fullscreen ? root.index == index ? root.width : 0 : root.cellWidth * cellColumns : 0
    height: root ? root.fullscreen ? root.index == index ? root.height : 0 : root.cellHeight * cellRows : 0
    opacity: root ? root.fullscreen ? root.index == index ? 1.0 : 0.0 : 1.0 : 1.0

    color: "slategrey"
    border.color: "ghostwhite"

    MouseArea {
        anchors.fill: parent
        onClicked: if (root) root.index = index;
        onDoubleClicked: if (root) root.fullscreen = !root.fullscreen;
        hoverEnabled: true
        onEntered: minorimage.visible = true
        onExited: minorimage.visible = false
    }

    Image {
        id: minorimage
        visible: false
        anchors { top: parent.top; right: parent.right }
        width: 16; height: 16
        source: "qrc:/pic/small/CloseTransparent3.png"

        MouseArea {
            anchors.fill: parent
            onClicked: console.log("...close in " + index)
        }
    }
}
