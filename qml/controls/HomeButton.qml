import QtQuick 2.8

Rectangle {
    id: control

    property alias iconSource: inimage.source
    property alias text: intext.text
    signal clicked()

    implicitWidth: 148
    implicitHeight: 148

    color: "#0072e3"
    border.color: "transparent"
    border.width: 2

    Image {
        id: inimage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: intext
        color: "white"
        font.family: "Microsoft YaHei UI"
        font.pointSize: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: inimage.bottom
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            control.border.color = "lightsteelblue"
        }
        onClicked: {
            control.clicked()
        }
        onExited: {
            control.border.color = "transparent"
        }
    }
}

