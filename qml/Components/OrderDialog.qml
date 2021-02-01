import QtQuick 2.12
import QtQuick.Controls 2.12

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: parent.width/2 - width/2
    y: parent.height/2 - height/2
    width:  parent.width-40
    height: 290
    modal: true; dim: true
    padding: 0

    Overlay.modal: Rectangle { color: "#A0000000" }

    property alias address: _address
    property alias comment: _comment.text
    property alias phone: _phone.text
    property bool showBusyIndicator: false

    signal payment(var obj)

    function reset() {
        _comment.text = ""
        showBusyIndicator = false
    }

    function verificate() {
        return _phone.text && _address.filled
    }

    onOpened: reset();

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
    }
    contentItem: Item {
        ImageButton {
            x: parent.width - 30
            y: 10
            width: 20; height: 20
            image: "qrc:/icons/exit-black.svg"
            onClicked: {
                _dialog.close()
            }
        }
        Column {
            x: 20; y: 10
            width: parent.width - 40
            spacing: 20
            Label {
                x: parent.width/2 - contentWidth/2
                font { pixelSize: 18; bold: true }
                text: qsTr("Оформление заказа")
            }
            InputPhoneField {
                id: _phone
                width: parent.width                
                horizontalAlignment: Text.AlignLeft                
                onAccepted: _address.forceActiveFocus()
            }
            InputAddressField {
                id: _address
                width: parent.width
                onAccepted: _comment.forceActiveFocus()
            }
            InputText {
                id: _comment
                width: parent.width
                placeholderText: qsTr("Коментарий")
            }
            CustomButton {
                x: parent.width/2 - width/2
                text: qsTr("Перейти к оплате")
                onClicked: {
                    if(_dialog.verificate()) {
                        var obj = {
                            "comment": _comment.text,
                            "address": {
                                "street": _address.street,
                                "house": _address.house,
                                "flat": _address.flat
                            },
                            "phone": _phone.getClearPhoneNumber()
                        }
                        _dialog.payment(obj)
                    } else {
                        _errorPopup.show(qsTr("Заполните поля телефона и адреса"))
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            radius: 10
            visible: _dialog.showBusyIndicator
            color: "#C0000000"

            CustomBusyIndicator {
                anchors.centerIn: parent
                width: 100; height: 100
                running: _dialog.showBusyIndicator
            }
        }
    }
}
