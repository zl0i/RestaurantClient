import QtQuick 2.12
import QtQuick.Controls 2.12

Drawer {
    id: _drawer
    y: parent.height - height
    width:  parent.width
    height: 0.3 *parent.height
    interactive: opened
    edge: Qt.BottomEdge

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
            y: 10
            padding: 20
            width: parent.width
            spacing: 5
            InputText {
                width: parent.width-40
            }
            InputText {
                width: parent.width-40
            }
            CustomButton {
                text: qsTr("Вход")
            }
        }
    }

}
