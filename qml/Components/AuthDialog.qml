import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: 20; y: parent.height/2 - height/2
    width: parent.width-40; height: registrationDialog ? 350 : 280
    modal: true; dim: true
    closePolicy: Dialog.NoAutoClose
    padding: 20
    clip: true

    Behavior on height {
        NumberAnimation { duration: 500; easing.type: Easing.OutQuint }
    }

    property bool registrationDialog: false
    signal input(var obj)
    signal registrationClicked(var obj)

    Overlay.modal: Rectangle {
        color: "#80000000"
    }

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
        }
    }

    contentItem: Item {
        ImageButton {
            width: 14; height: 9
            visible: _dialog.registrationDialog
            image: "qrc:/icons/arrowBack-black.svg"
            onClicked: {
                _dialog.registrationDialog = false
            }
        }

        Column {                   
            width: parent.width
            spacing: 15
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font { pixelSize: 24; bold: true }
                text: _dialog.registrationDialog ? qsTr("Регистрация") : qsTr("Вход")
            }
            InputText {
                id: _name
                width: parent.width
                visible: _dialog.registrationDialog
                placeholderText: qsTr("Имя")
                text: "Дмитрий"
            }
            InputText {
                id: _phoneNumber
                width: parent.width
                placeholderText: qsTr("Номер телефона")
                text: "89202173095"
            }
            InputText {
                id: _password
                width: parent.width
                placeholderText: qsTr("Пароль")
                echoMode: TextInput.Password
                passwordMaskDelay: 500
                text: "1996q1996w"
            }
            InputAddressField {
                id: _address
                width: parent.width
                visible: _dialog.registrationDialog
                street: "Морская"
                house: "46"
                flat: "18"
            }
            CustomButton {
                x: parent.width/2 - width/2
                visible: !_dialog.registrationDialog
                text: qsTr("Вход")
                onClicked: {
                    var obj = {
                        "phoneNumber": _phoneNumber.text,
                        "password": _password.text
                    }
                    _dialog.input(obj)
                }
            }
            CustomButton {
                x: parent.width/2 - width/2
                state: _dialog.registrationDialog ? "green" : "opacity"
                text: qsTr("Регистрация")
                onClicked: {
                    if(_dialog.registrationDialog) {
                        var obj = {
                            "name": _name.text,
                            "phoneNumber": _phoneNumber.text,
                            "password": _password.text,
                            "address": {
                                "street": _address.street,
                                "house": _address.house,
                                "flat": _address.flat
                            }
                        }
                        _dialog.registrationClicked(obj)
                    } else {
                        _dialog.registrationDialog = true
                    }
                 }
            }
        }
    }
}
