import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegate

    property string name

    Rectangle {
        width: parent.width; height: 1
        color: "#C4C4C4"
    }
    Rectangle {
        y: parent.height-1
        width: parent.width; height: 1
        color: "#C4C4C4"
    }

    Image {
        x: 20; y: 10
        width: 60; height: 60
        //source: "file"
    }
    Label {
        x: 120; y: 10
        font.pixelSize: 20
        text: _delegate.name
    }
}
