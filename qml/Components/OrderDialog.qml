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

    signal access()

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 20        
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
            InputText {
                id: _phone
                width: parent.width
                placeholderText: qsTr("Телефон")
            }
            InputAddressField {
                id: _address
                width: parent.width
            }
            InputText {
                id: _comment
                width: parent.width
                placeholderText: qsTr("Коментарий")
            }
            CustomButton {
                x: parent.width/2 - width/2
                text: qsTr("Перейти к оплате")
                onClicked: _dialog.access()
            }
        }
    }
}
