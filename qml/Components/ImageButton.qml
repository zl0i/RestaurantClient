import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: _button

    property real imageWidth: width
    property real imageHeight: height
    property string image
    property int rotation: 0

    property alias pressed: _mouseArea.pressed

    signal clicked()

    Image {
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
        width: _button.imageWidth
        height: _button.imageHeight
        rotation: _button.rotation
        source: _button.image
        layer.enabled: true
        layer.effect: ColorOverlay {
            color:  "#000000"
        }
    }

    MouseArea {
        id: _mouseArea
        width: parent.width
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true        
        onClicked: _button.clicked()
    }

}
