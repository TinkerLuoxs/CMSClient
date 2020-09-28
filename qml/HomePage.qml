import QtQuick 2.8
import QtQuick.Controls 2.2
import "controls" as Controls

Item {
    property var pageArray: [null, null, null, null, null, null, null, null, null]

    Component {
        id: compTabButton
        Controls.TabButton {
            onClicked: activeTitleBar.currentIndex = index
            onClosed: {
                swipeView.removeItem(index)
                activeTitleBarContainer.removeItem(index)
                pageArray[seq].destroy(1000)
                pageArray[seq] = null
                destroy()
            }
        }
    }

    function pageSwitching(item, seq, qml) {
        if (pageArray[seq] == null) {
            var index = swipeView.count

            pageArray[seq] = Qt.createQmlObject(qml, swipeView, null)
            pageArray[seq].pageIndex = index
            swipeView.addItem(pageArray[seq])

            var tabItem = compTabButton.createObject(activeTitleBarContainer)
            tabItem.seq = seq
            tabItem.index = index
            tabItem.iconSource = item.iconSource
            activeTitleBarContainer.addItem(tabItem)
        }
        activeTitleBar.currentIndex = pageArray[seq].pageIndex
    }

    Grid {
        anchors {
            left: parent.left
            leftMargin: 8
            right: parent.right
            rightMargin: -8
            top: parent.top
            topMargin: 8
            bottom: parent.bottom
            bottomMargin: -8
        }

        spacing: 4

        Controls.HomeButton {
            text: qsTr("Real-time Preview")
            iconSource: "qrc:/pic/HomePage/RealTimePlay.png"
            onClicked: pageSwitching(this, 0, 'RealtimePreview {}')
        }
        Controls.HomeButton {
            text: qsTr("Video Playback")
            iconSource: "qrc:/pic/HomePage/PlayBack.png"
            onClicked: pageSwitching(this, 1, 'VideoPlayback {}')
        }
        Controls.HomeButton {
            text: qsTr("Alarm Manager")
            iconSource: "qrc:/pic/HomePage/AlarmMng.png"
            onClicked: pageSwitching(this, 2, 'CommonPage {}')
        }
        Controls.HomeButton {
            text: qsTr("Device Manager")
            iconSource: "qrc:/pic/HomePage/DevMng.png"
            onClicked: pageSwitching(this, 3, 'DeviceManager {}')
        }
        Controls.HomeButton {
            text: qsTr("Device Configure")
            iconSource: "qrc:/pic/HomePage/DevConfig.png"
            onClicked: pageSwitching(this, 4, 'CommonPage {}')
        }
        Controls.HomeButton {
            text: qsTr("User Manager")
            iconSource: "qrc:/pic/HomePage/UserMng.png"
            onClicked: pageSwitching(this, 5, 'CommonPage {}')
        }
        Controls.HomeButton {
            text: qsTr("Statistic-form Manager")
            iconSource: "qrc:/pic/HomePage/ReportMng.png"
            onClicked: pageSwitching(this, 6, 'CommonPage {}')
        }
        Controls.HomeButton {
            text: qsTr("TV Wall Manager")
            iconSource: "qrc:/pic/HomePage/TVWall.png"
            onClicked: pageSwitching(this, 7, 'CommonPage {}')
        }
        Controls.HomeButton {
            text: qsTr("Operate Log")
            iconSource: "qrc:/pic/HomePage/LogQuery.png"
            onClicked: pageSwitching(this, 8, 'CommonPage {}')
        }
    }
}




