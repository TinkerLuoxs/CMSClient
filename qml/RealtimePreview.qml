import QtQuick 2.8
import QtQuick.Controls 2.2
import "controls" as Controls

CommonPage {
    Controls.SplitView {
        id: videoPlayPage
        width: parent.width - deviceListPage.width
        height: parent.height - splitButtonPage.height

        model: [2, 2, 4]

        Controls.SplitELement {}
        Controls.SplitELement {}
        Controls.SplitELement {}
        Controls.SplitELement {}
    }

    Controls.TreeView {
        anchors.right: parent.right
        width: 200; height: parent.height
        id: deviceListPage
        title: qsTr("Device list")
    }

    Item {
        id: splitButtonPage
        anchors.bottom: parent.bottom
        width: parent.width - deviceListPage.width
        height: 80

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Single2.png" : "qrc:/pic/PlayScreen/Single.png"
                onClicked: {
                    videoPlayPage.model = [1, 1, 1]
                    videoPlayPage.resetData(1)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Four2.png" : "qrc:/pic/PlayScreen/Four.png"
                onClicked: {
                    videoPlayPage.model = [2, 2, 4]
                    videoPlayPage.resetData(4)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Six2.png" : "qrc:/pic/PlayScreen/Six.png"
                onClicked: {
                    videoPlayPage.model = [3, 3, 6]
                    videoPlayPage.resetData(6)
                    videoPlayPage.setData(0, 2, 2)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Eight2.png" : "qrc:/pic/PlayScreen/Eight.png"
                onClicked: {
                    videoPlayPage.model = [4, 4, 8]
                    videoPlayPage.resetData(8)
                    videoPlayPage.setData(0, 3, 3)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Nine2.png" : "qrc:/pic/PlayScreen/Nine.png"
                onClicked: {
                    videoPlayPage.model = [3, 3, 9]
                    videoPlayPage.resetData(9)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Sixteen2.png" : "qrc:/pic/PlayScreen/Sixteen.png"
                onClicked: {
                    videoPlayPage.model = [4, 4, 16]
                    videoPlayPage.resetData(16)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/TwentyFive2.png" : "qrc:/pic/PlayScreen/TwentyFive.png"
                onClicked: {
                    videoPlayPage.model = [5, 5, 25]
                    videoPlayPage.resetData(25)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/ThirtySix2.png" : "qrc:/pic/PlayScreen/ThirtySix.png"
                onClicked: {
                    videoPlayPage.model = [6, 6, 36]
                    videoPlayPage.resetData(36)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/SixtyFour2.png" : "qrc:/pic/PlayScreen/SixtyFour.png"
                onClicked: {
                    videoPlayPage.model = [8, 8, 64]
                    videoPlayPage.resetData(64)
                    videoPlayPage.updateData()
                }
            }
            Controls.PicButton {
                iconSource: entered ? "qrc:/pic/PlayScreen/Custom2.png" : "qrc:/pic/PlayScreen/Custom.png"
            }
        }
    }
}
