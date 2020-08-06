import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _button
    width: _label.contentWidth + 60; height: 40; radius: 10
    color: _mouseArea.pressed ? pressedColor : releasedColor

    property string text
    property string extractText
    property bool enableShadow: false
    property alias label: _label
    property alias exLabel: _extractLabel

    signal clicked()

    property color pressedColor: "#25D500"
    property color releasedColor: "#4FD65C"
    property color disableColor: "#D3D3D3"

    property color pressedTextColor: "#FFFFFF"
    property color releasedTextColor: "#FFFFFF"

    states: [
        State {
            name: "green"
            PropertyChanges {
                target: _button
                pressedColor: "#25D500"
                releasedColor: "#4FD65C"
                disableColor: "#D3D3D3"
                pressedTextColor: "#FFFFFF"
                releasedTextColor: "#FFFFFF"
                height: 35
            }
        },
        State {
            name: "opacity"
            PropertyChanges {
                target: _button
                pressedTextColor: "#4FD65C"
                releasedTextColor: "#25D500"
                pressedColor: "#00000000"
                releasedColor: "#00000000"
                height: 20
            }
        }
    ]
    state: "green"

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
