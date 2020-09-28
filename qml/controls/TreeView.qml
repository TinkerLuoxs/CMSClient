import QtQuick 2.8
import QtQuick.Controls 2.2

ListView {
    id: root

    property string title: "default"
    readonly property int rowHeight: 28

    clip: true
    flickableDirection: Flickable.AutoFlickIfNeeded
    ScrollBar.horizontal: ScrollBar { id: hbar; active: vbar.active }
    ScrollBar.vertical: ScrollBar { id: vbar; active: hbar.active }

    delegate: Text {
        height: 18
        verticalAlignment: Text.AlignVCenter
        leftPadding: 20
        text: name
        onContentWidthChanged: {
            if (root.contentWidth < width)
                root.contentWidth = width
        }
    }
    section {
        property: "group"
        criteria: ViewSection.FullString
        delegate: Text {
            height: 18
            verticalAlignment: Text.AlignVCenter
            text: section
        }
    }
    header: Text {
        width: root.width; height: 30
        text: root.title
        font.family: "Consolas"
        font.pointSize: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#e4e4e4"
    }
}
