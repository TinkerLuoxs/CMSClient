import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQml.Models 2.2

Rectangle {
    id: root
    border.color: "#e4e4e4"

    property list<TableElement> header
    property bool orderByColumn: false
    property alias model: tableContentVisualModel.model

    Flickable {
        id: view
        anchors.centerIn: parent
        width: parent.width - 2
        height: parent.height

        clip: true
        interactive: false // disable drag

        readonly property int rowHeight: 28
        readonly property int rowWidth: {
            var len = 0
            for (var i = 0; i < root.header.length; ++i)
                len += root.header[i].width
        }

        contentWidth: rowWidth

        ListView {
            id: tableHeader
            orientation: ListView.Horizontal
            width: parent.width; height: view.rowHeight
            interactive: false

            model: root.header.length
            delegate: Button {
                id: tableHeaderField
                width: element.width; height: parent.height
                readonly property var element: root.header[index]
                hoverEnabled: root.orderByColumn ? true : false
                background: Rectangle {
                    color: tableHeaderField.hovered ? "#f3f9fe" : "#fffff9"
                    border.color: "#e4e4e4"
                }
                contentItem: Text {
                    text: tableHeaderField.element.title
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    if (root.orderByColumn)
                        tableContentVisualModel.sortOrder = index
                }

                Rectangle {
                    anchors { right: parent.right }
                    width: 2; height: parent.height
                    color: "#e4e4e4"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.SplitHCursor
                        property real pressX: 0
                        onPressed: pressX = mouse.x
                        onPositionChanged: {
                            tableHeaderField.element.width += mouseX - pressX
                            if (tableHeaderField.element.width <= 30)
                                tableHeaderField.element.width = 30
                            else {
                                var w = root.x + root.width - tableHeaderField.x - 30;
                                if (tableHeaderField.element.width >= w)
                                    tableHeaderField.element.width = w
                            }
                        }
                    }
                }
            }
        }

        ListView {
            id: tableContent
            anchors { top: tableHeader.bottom; bottom: parent.bottom }
            width: parent.width
            model: tableContentVisualModel
            ScrollBar.vertical: ScrollBar { id: vbar; active: hbar.active }
        }

        DelegateModel {
            id: tableContentVisualModel

            property int sortOrder: -1
            onSortOrderChanged: items.setGroups(0, items.count, "unsorted")
            property int highlight: 0

            function lessThan(left, right) {
                var role = root.header[sortOrder].role
                return left[role] < right[role]
            }
            function insertPosition(item) {
                var lower = 0
                var upper = items.count
                while (lower < upper) {
                    var middle = Math.floor(lower + (upper - lower) / 2)
                    var result = lessThan(item.model, items.get(middle).model);
                    if (result) {
                        upper = middle
                    } else {
                        lower = middle + 1
                    }
                }
                return lower
            }
            function sort() {
                while (unsortedItems.count > 0) {
                    var item = unsortedItems.get(0)
                    var index = insertPosition(item)

                    item.groups = "items"
                    items.move(item.itemsIndex, index)
                }
            }
            groups: VisualDataGroup {
                id: unsortedItems
                name: "unsorted"
                onChanged: tableContentVisualModel.sort()
            }
            delegate: Rectangle {
                id: tableContentField
                width: tableContent.width; height: view.rowHeight

                function textName(role) {
                    return model && model.hasOwnProperty(role) ? model[role] // Qml ListModel and QAbstractItemModel
                           : modelData && modelData.hasOwnProperty(role) ? modelData[role] // QObjectList / QObject
                           : modelData != undefined ? modelData : "" // Models without role
                }

                ListView {
                    anchors.fill: parent
                    orientation: ListView.Horizontal
                    interactive: false
                    model: root.header.length
                    delegate: Text {
                        readonly property var element: root.header[index]
                        width: element.width; height: parent.height
                        clip: true
                        leftPadding: 8
                        verticalAlignment: Text.AlignVCenter
                        text: tableContentField.textName(element.role)
                    }
                }
                color: tableContentVisualModel.highlight == index ? "lightgray" : "transparent"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        tableContentVisualModel.highlight = index
                        console.log("table view content in " + index)
                    }
                    hoverEnabled: true
                    onEntered: tableContentField.border.color = "lightskyblue"
                    onExited: tableContentField.border.color = "transparent"
                }
            }
        }

        ScrollBar.horizontal: ScrollBar { id: hbar; active: vbar.active }
    }

}
