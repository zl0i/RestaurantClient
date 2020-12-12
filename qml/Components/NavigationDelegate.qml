import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: _item
    property string text
    property real iconWidth: width/2
    property real iconHeight: height/2
    property string icon
    readonly property alias pressed: _mouseArea.pressed

    property bool selected: false

    property color pressedColor: "#5AD166"
    property color releasedColor: "#000000"

    signal clicked()

    Row {
        anchors.centerIn: parent
        spacing: 15
        Image {
            width: _item.iconWidth
            height: _item.iconHeight
            source: _item.icon
            fillMode: Image.PreserveAspectFit
            layer.enabled: _item.pressed || _item.selected
            layer.effect: ColorOverlay {
                color: _item.pressedColor
            }
        }
        Label {
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            color: (_item.pressed || _item.selected) ? _item.pressedColor : _item.releasedColor
            font.pixelSize: 14
            text: _item.text
        }
    }



    MouseArea {
        id: _mouseArea
        width: parent.width; height: parent.height
        onClicked: _item.clicked()
    }
}
