import QtQuick 2.7
import QtQuick.Controls 2.2

CheckBox {
    id: control

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16
        y: parent.height / 2 - height / 2
        radius: 3
        border.color: "darkgray"

        Rectangle {
            x: 4; y: 4; width: 8; height: 8
            radius: 2
            color: "#21be2b"
            visible: control.checked
        }
    }

    contentItem: Text {
        text: parent.text
        font.family: "Consolas"
        font.pointSize: 10
        leftPadding: parent.indicator.width
    }
}
