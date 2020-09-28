import QtQuick 2.8
import QtQuick.Controls 2.2

ComboBox {
    id: control

    delegate: ItemDelegate {
        width: control.width
        text: modelData
        font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
        highlighted: control.highlightedIndex == index
    }

    indicator: Canvas {
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 10; height: 8

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.moveTo(0, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width / 2, height);
            ctx.closePath();
            ctx.fillStyle = "#21be2b";
            ctx.fill();
        }
    }

    contentItem: Text {
        leftPadding: 4
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 28
        border.color: "lightgrey"
        border.width: control.visualFocus ? 2 : 1
    }
}
