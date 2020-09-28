import QtQuick 2.8

Rectangle {
    id: root
    implicitWidth: 32
    implicitHeight: 24

    property alias iconSource: image.source
    property bool entered: false

    color: "transparent"

    signal clicked()

    Image {
        id: image
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.entered = true
        onExited: root.entered = false
        onClicked: root.clicked()
    }
}

