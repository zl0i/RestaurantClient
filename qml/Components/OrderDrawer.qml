import QtQuick 2.12
import QtQuick.Controls 2.12

Drawer {
    id: _drawer
    y: parent.height - height
    width:  parent.width
    height: 240//0.6 *parent.height
    interactive: opened
    edge: Qt.BottomEdge
    padding: 20

    property alias address: _address.text
    property string comment: _comment.text

    signal access()

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 20
        Rectangle {
            y: parent.height-height
            width: parent.width; height: 20
        }
    }
    contentItem: Item {

        Rectangle {
            x: parent.width/2 - width/2; y: 5
            width: 80; height: 4; radius: 2
            color: "#C4C4C4"
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
                id: _address
                width: parent.width
                placeholderText: qsTr("Адрес")
                passwordMaskDelay: 500
            }
            InputText {
                id: _comment
                width: parent.width
                placeholderText: qsTr("Коментарий")
            }
            CustomButton {
                x: parent.width/2 - width/2
                text: qsTr("Применить")
                onClicked: _drawer.access()
            }
        }
    }
}
