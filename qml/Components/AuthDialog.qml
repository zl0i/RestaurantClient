import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.15
import QtGraphicalEffects 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: 20; y: parent.height/2 - height/2
    width: parent.width-40; height: 230
    modal: true; dim: true
    padding: 20
    clip: true

    property string phone

    signal inputPhone(string phone)
    signal inputCode(string code)

    function reset() {
        _phoneNumber.text = ""
        _swipe.currentIndex = 0
        _codeInput.text = ""
        _inputCodePage.smsTimer = 90
        _inputCodePage.smsCount = 1
    }

    onOpened: reset();

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
                id: _phoneInputPage
                width: _swipe.width
                height: _swipe.height

                function verify() {
                    if(_phoneNumber.acceptableInput) {
                        _swipe.currentIndex++
                        _timer.start()
                        _codeInput.forceActiveFocus()
                        return true
                    }
                    return false
                }

                function nextPage() {
                    if(_phoneInputPage.verify()) {
                        _dialog.inputPhone(_phoneNumber.getClearPhoneNumber())
                    } else {
                        _errorPopup.show(qsTr("Введите корректный номер телефона"))
                    }
                }

                InputPhoneField {
                    id: _phoneNumber
                    y: 20
                    width: parent.width
                    text: _dialog.phone
                    onAccepted: _phoneInputPage.nextPage()
                }
                CustomButton {
                    x: parent.width/2 - width/2
                    y: parent.height - height - 15
                    text: qsTr("Далее")
                    onClicked: _phoneInputPage.nextPage()
                }
            }
            Item {
                id: _inputCodePage
                width: _swipe.width
                height: _swipe.height

                property int smsTimer: 90
                property int smsCount: 1

                InputCode {
                    id: _codeInput
                    x: parent.width/2 - width/2
                    font { pixelSize: 24; bold: true }
                    onAccepted: _dialog.inputCode(_codeInput.code)
                }

                Timer {
                    id: _timer
                    interval: 1000
                    running: false
                    repeat: true
                    onTriggered: {
                        if(_inputCodePage.smsTimer > 0)
                            _inputCodePage.smsTimer--
                        else {
                            _timer.stop()
                        }
                    }
                }

                Label {
                    y: 70
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    text: _timer.running ? qsTr("Повторная отправка кода возможна через %1 сек").arg(_inputCodePage.smsTimer) :
                                           qsTr("Отправить повторно")
                    font.underline: !_timer.running
                    MouseArea {
                        anchors.fill: parent
                        enabled: !_timer.running
                        onClicked: {
                            _inputCodePage.smsCount++
                            _inputCodePage.smsTimer = 90 * _inputCodePage.smsCount
                            _timer.start()
                            _dialog.inputPhone(_phoneNumber.getClearPhoneNumber())
                        }
                    }
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
