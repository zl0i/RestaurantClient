import QtQuick 2.12
import QtQuick.Controls 2.12

Drawer {
    id: _drawer
    y: parent.height - height
    width:  parent.width
    height: 0.6 *parent.height
    interactive: opened
    edge: Qt.BottomEdge

    property string name
    property string image
    property string info

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
            width: parent.width
            spacing: 5
            Label {
                x: parent.width/2 - contentWidth/2
                font { pixelSize: 18; bold: true }
                text: _drawer.name
            }

            Image {
                width: parent.width; height: 200
                fillMode: Image.PreserveAspectCrop
                source: _drawer.image
            }
            Flickable {
                width: parent.width; height: 150
                contentHeight: _info.contentHeight+10
                clip: true
                ScrollBar.vertical: ScrollBar {}
                Label {
                    id: _info
                    width: parent.width
                    padding: 10
                    wrapMode: Text.WordWrap
                    font.pixelSize: 16
                    text: _drawer.info
                }
            }
        }
    }
}
