import QtQuick 2.12
import QtQuick.Controls 2.12

TextInput {
    id: _inputCode
    width: count * widthField + (count - 1) * _listField.spacing
    height: 50
    bottomPadding: 0
    maximumLength: count
    color: "transparent"
    clip: true
    cursorVisible: false
    cursorDelegate: Item {}
    inputMethodHints: Qt.ImhDigitsOnly

    onTextChanged: {
        if(text.length === _inputCode.count) {
            isFull = true
            filled(text)
        } else {
            isFull = false
        }
    }

    property string code: text
    property int count: 4
    property int spacing: 30

    property bool isFull: false

    property int widthField: 50
    property int heightField: 50

    signal filled(string code)

    function getCode() {
        return text
    }

    function reset() {
        isFull = false
        text = ""
    }

    onFocusChanged: {
        if(focus)
            cursorPosition = text.length
    }

    ListView{
        id: _listField
        width: parent.width
        height: parent.height

        model: _inputCode.count
        orientation: ListView.Horizontal
        interactive: false
        spacing: _inputCode.spacing

        delegate:  Label {
            id: _delegate
            width: _inputCode.widthField
            height: _inputCode.heightField
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            bottomPadding: 0
            font: _inputCode.font
            color: "#000000"
            Binding {
                target: _delegate
                property: "text"
                value: _inputCode.text[index] ? _inputCode.text[index] : ""
            }
            background: Item {
                width: parent.width
                height: parent.height
                Rectangle {
                    y: parent.height-1
                    width: parent.width
                    height: 2
                    color: "#5AD166"
                }
            }
        }
    }
}

