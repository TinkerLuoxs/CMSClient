import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import "controls" as Controls

Image {
    width: 480; height: 360

    property alias username: _username.text
    property alias password: _password.text
    property alias passwordSaved: _rememberPassword.checked
    property alias autoLogined: _autoLogin.checked

    source: "qrc:/pic/loginBackground.png"

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        property point clickPos: "0,0"
        onPressed: clickPos = Qt.point(mouse.x,mouse.y)
        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            loginWindow.setX(loginWindow.x+delta.x)
            loginWindow.setY(loginWindow.y+delta.y)
        }
    }

    Row {
        anchors { top: parent.top; right: parent.right }
        layoutDirection: Qt.RightToLeft
        spacing: 4

        Controls.PicButton {
            width: 20; height: 20
            iconSource: "qrc:/pic/small/CloseTransparent.png"
            color: entered ? "red" : "transparent"
            onClicked: Qt.quit()
        }

        Controls.PicButton {
            width: 20; height: 20
            iconSource: "qrc:/pic/small/MinTransparent.png"
            color: entered ? "deepskyblue" : "transparent"
            onClicked: loginWindow.visibility = Window.Minimized
        }
    }

    Column {
        x: 150; y: 100
        spacing: 8

        TextField {
            id: _username
            placeholderText: qsTr("username")
        }

        TextField {
            id: _password
            placeholderText: qsTr("password")
            echoMode: TextInput.Password
        }

        Row {
            spacing: 16

            Controls.CheckBox {
                id: _rememberPassword
                text: qsTr("RememberMe")
            }

            Controls.CheckBox {
                id: _autoLogin
                text: qsTr("AutoLogin")
                onClicked: if (checked) _rememberPassword.checked = true
            }
        }

        Row {
            spacing: 38

            Controls.PureButton {
                id: _login
                text: qsTr("Sign In")
                onClicked: onLogin()
            }

            Controls.PureButton {
                id: _cancel
                text: qsTr("Sign Out")
                onClicked: onCancel()
            }
        }

        Text {
            id: _warning
            color: "red"
            font.family: "Consolas"
            font.bold: true
            font.pointSize: 12
        }
    }

    function init() {
        if (username == "")
            _username.focus = true
        else if (password == "")
            _password.focus = true

        if (autoLogined)
            _warning.text = qsTr("User already sign-in")
    }

    function onLogin() {
        _login.enabled = false

        do {
            if (username == "") {
                _warning.text = qsTr("Input username. please!")
                break
            }

            if (password == "") {
                _warning.text = qsTr("Input password. please!")
                break
            }

            if (cppLogin.login(username, password, passwordSaved, autoLogined))
                Qt.quit()
            else
                _warning.text = qsTr("Username or password error!")
        }while(0)

        _login.enabled = true
    }

    function onCancel() {
        Qt.quit()
    }

}
