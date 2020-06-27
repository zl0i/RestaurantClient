import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegate

    property string name
    property string image

    signal clicked();

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
        x: 20; y: 10
        width: 60; height: 60
        radius: 5
        color: "#00000000"
        border { width: 2; color: "#C4C4C4" }
        Image {
            x: parent.width/2 - width/2; y: parent.height/2 - height/2
            width: 40; height: 40
            source: _delegate.image
        }
    }

    Label {
        x: 120; y: 10
        font.pixelSize: 20
        text: _delegate.name
    }

    MouseArea {
        width: parent.width; height: parent.height
        onClicked: _delegate.clicked()
    }
}
