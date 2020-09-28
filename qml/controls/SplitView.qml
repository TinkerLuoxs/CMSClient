import QtQuick 2.8
import QtQuick.Controls 2.2

Container {
    id: container

    property var model: [1, 1, 1] // [rows, columns, components]

    Component {
        id: elementComponent
        SplitELement {}
    }

    function resetData(size) {
        for (var i in contentChildren) {
            var item = contentChildren[i]
            if (item.cellRows == 1 && item.cellColumns == 1)
                continue
            item.cellRows = 1
            item.cellColumns = 1
        }
        var len = contentChildren.length
        if (len >= size)
            return
        for (; len < size; ++len) {
            container.addItem(elementComponent.createObject(container))
        }
    }

    function setData(index, cellRows, cellColumns) {
        var item = contentChildren[index]
        item.cellRows = cellRows
        item.cellColumns = cellColumns
    }

    function updateData() {
        __root.display()
    }

    contentItem: Item {
        id: __root

        readonly property int rows: container.model[0]
        readonly property int columns: container.model[1]

        readonly property real cellWidth: width / columns
        readonly property real cellHeight: height / rows
        property bool fullscreen: false
        property int index: 0

        Rectangle {
            id: highlight
            anchors.fill: container.contentChildren[0]
            z: 1
            color: "transparent"; border.color: "deepskyblue"
        }

        onIndexChanged: highlight.anchors.fill = container.contentChildren[index]

        function enableVisible() {
            var arr = container.contentChildren
            for (var i = 0; i < arr.length; ++i) {              
                arr[i].visible = i < container.model[2] ? true : false
            }
        }
        function contain(arr, val) {
            for (var n in arr)
                if (arr[n] == val)
                    return true
            return false
        }
        function initDelegate() {
            var c = []
            var k = 0
            var arr = container.contentChildren
            for (var i = 0; i < rows; ++i) {
                for (var j = 0; j < columns; ++j) {
                    if (k >= container.model[2])
                        return
                    if (contain(c, i * columns + j))
                        continue
                    var item = arr[k]
                    item.root = __root
                    item.index = k
                    item.cellX = j
                    item.cellY = i

                    for (var n = 0; n < item.cellRows; ++n) {
                        for (var m = 0; m < item.cellColumns; ++m) {
                            if (n == 0 && m == 0)
                                continue
                            var val = (i + n) * columns + (j + m)
                            c.push(val)
                        }
                    }
                    ++k
                }
            }
        }
        function display() {
            enableVisible()
            initDelegate()
        }

        Component.onCompleted: display()
    }

    onModelChanged: __root.display()
}
