import QtQuick 2.8

Rectangle {
    id: control

    property int seq: -1
    property int index: -1
    property bool closeEnabled: true
    property bool entered: false
    property alias iconSource: majorImage.source

    signal clicked()
    signal closed()

    implicitWidth: 85
    implicitHeight: 65

    Image {
        id: majorImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    color: entered ? "#898989" : "transparent"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: control.entered = true
        onExited: control.entered = false
        onClicked: control.clicked()
    }

    Image {
        id: minorImage
        visible: control.closeEnabled ? control.entered ? true : false : false
        anchors { top: parent.top; right: parent.right }
        width: 16; height: 16
        source: "qrc:/pic/small/CloseTransparent3.png"

        MouseArea {
            anchors.fill: parent
            onClicked: control.closed()
        }
    }
}
