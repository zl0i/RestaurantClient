import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: _button
    width: _label.contentWidth + 60; height: 35; radius: 10
    color: _mouseArea.pressed ? pressedColor : releasedColor

    property string text

    signal clicked()

    property color pressedColor: "#25D500"
    property color releasedColor: "#4FD65C"
    property color disableColor: "#D3D3D3"

    Label {
        id: _label
        width: parent.width
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#FFFFFF"
        font.pixelSize: 16
        text: _button.text
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
