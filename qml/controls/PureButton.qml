import QtQuick 2.8
import QtQuick.Controls 2.2

Button {
    id: control

    hoverEnabled: true

    contentItem: Text {
        text: control.text
        font.family: "Consolas"
        font.pointSize: 10
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 30
        color: control.hovered ? "deepskyblue" : "dodgerblue"
        border.color: "lightblue"
        border.width: 1
        radius: 4
    }
}
