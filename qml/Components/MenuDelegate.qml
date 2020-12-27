import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegate

    property string menu_id
    property string name
    property string image
    property real cost: 0
    property alias count: _counter.count

    signal clicked()

    signal editedCount()

    Rectangle {
        width: parent.width; height: 1
        color: "#C4C4C4"
    }
    Rectangle {
        y: parent.height-1
        width: parent.width; height: 1
        color: "#C4C4C4"
    }

    Rectangle {
        x: 20; y: parent.height/2 - height/2
        width: 80; height: 80
        radius: 5        
        color: "#00000000"
        border { width: 2; color: "#C4C4C4" }
        Image {
            id: _prototypeImage
            x: parent.width/2 - width/2; y: parent.height/2 - height/2
            width: 50; height: 50
            antialiasing: true
            source: "qrc:/icons/burger-black.svg"
        }
        Image {            
            visible: false
            width: 80; height: 80
            fillMode: Image.PreserveAspectCrop
            source: _delegate.image
            onStatusChanged: {
                if(status === Image.Ready) {
                    visible = true
                    _prototypeImage.visible = false
                }
            }
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: 80; height: 80; radius: 5
                }
            }
        }
    }

    Label {
        x: 120; y: 10
        font.pixelSize: 20
        text: _delegate.name
    }
    Label {
        x: 120; y: parent.height - 40
        font.pixelSize: 24
        color: "#707070"
        text: _delegate.cost + " р."
    }

    MouseArea {
        width: parent.width; height: parent.height
        onClicked: _delegate.clicked()
    }

    AddBasketItem {
        id: _counter
        x: parent.width - width; y: parent.height - 40        
        onIncrement: _delegate.editedCount()
        onDecrement: _delegate.editedCount()
    }
}
