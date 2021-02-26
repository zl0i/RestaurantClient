import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _button
    width: _label.contentWidth + 60; height: 35; radius: 10
    color: _mouseArea.pressed ? pressedColor : releasedColor

    property string text
    property string extractText
    property bool enableShadow: false
    property alias label: _label
    property alias exLabel: _extractLabel

    signal clicked()

    property color pressedColor: "#25D500"
    property color releasedColor: "#5AD166"
    property color disableColor: "#D3D3D3"

    property color pressedTextColor: "#FFFFFF"
    property color releasedTextColor: "#FFFFFF"

    layer.enabled: enableShadow
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }

    Label {
        id: _label
        leftPadding: _button.extractText ? 20 : 0
        width: parent.width
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: _button.extractText ? Text.AlignLeft : Text.AlignHCenter
        color: _mouseArea.pressed ? _button.pressedTextColor : _button.releasedTextColor
        font { pixelSize: 16; bold: true }
        text: _button.text
    }
    Label {
        id: _extractLabel
        x: parent.width - width- 20
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        color: _mouseArea.pressed ? _button.pressedTextColor : _button.releasedTextColor
        font { pixelSize: 16; bold: true }
        text: _button.extractText
    }

    MouseArea {
        id: _mouseArea
        width: parent.width
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            _button.clicked()
        }
    }
}
