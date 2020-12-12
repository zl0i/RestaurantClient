import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: 20; y: parent.height/2 - height/2
    width: parent.width-40; height: 220
    modal: true; dim: true
    //closePolicy: Dialog.NoAutoClose
    padding: 20
    clip: true

    property string phone

    signal inputPhone(string phone)
    signal inputCode(string code)

    Overlay.modal: Rectangle {
        color: "#A0000000"
    }

    background: Rectangle { radius: 10 }

    contentItem: Item {
        Label {
            x: 10
            width: parent.width-10
            horizontalAlignment: Text.AlignHCenter
            font { pixelSize: 24; bold: true }
            text: qsTr("Вход")
        }

        SwipeView {
            id: _swipe
            y: 35
            width: parent.width
            height: parent.height - y
            spacing: 20
            interactive: false

            Item {
                width: _swipe.width
                height: _swipe.height

                InputText {
                    id: _phoneNumber
                    y: 20
                    width: parent.width
                    placeholderText: qsTr("Номер телефона")
                    text: _dialog.phone
                }
                CustomButton {
                    x: parent.width/2 - width/2
                    y: parent.height - height
                    text: qsTr("Далее")
                    onClicked: {
                        _swipe.currentIndex++
                        _codeInput.forceActiveFocus()
                        _dialog.inputPhone(_phoneNumber.text)
                    }
                }
            }
            Item {
                id: _inputCodePage
                width: _swipe.width
                height: _swipe.height

                property int smsTimer: 90

                InputCode {
                    id: _codeInput
                    x: parent.width/2 - width/2
                    font { pixelSize: 24; bold: true }
                }

                Timer {
                    id: _timer
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        if(_inputCodePage.smsTimer > 0)
                            _inputCodePage.smsTimer--
                    }
                }

                Label {
                    y: 70
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("Повторная отправка кода возможна через %1 сек").arg(_inputCodePage.smsTimer)
                }

                CustomButton {
                    x: parent.width/2 - width/2
                    y: parent.height - height
                    text: qsTr("Войти")
                    onClicked: _dialog.inputCode(_codeInput.code)
                }
            }
        }

    }
}
