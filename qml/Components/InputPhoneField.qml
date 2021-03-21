import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.15

InputText {
    id: _phoneNumber
    width: parent.width
    inputMask: "+7 (999) 999-99-99;_"
    inputMethodHints: Qt.ImhDigitsOnly
    horizontalAlignment: Text.AlignHCenter
    placeholderText: qsTr("Номер телефона")

    onCursorPositionChanged: {
        var pos = text.length
        var posText = _phoneNumber.getPositionCursorByText()
        if(_phoneNumber.focus) {
            if(pos < 4) {
                _phoneNumber.cursorPosition = 4
            } else if(pos > posText) {
                _phoneNumber.cursorPosition = posText
            } else {
                _phoneNumber.cursorPosition = pos
            }
        } else {
            _phoneNumber.cursorPosition = posText
        }
    }

    function getClearPhoneNumber() {
        var re = new RegExp(/[-)( ]/g);
        return text.replace(re, "");
    }

    function getPositionCursorByText() {
        const len = text.replace(/[-)(]/g, "").length
        switch(len) {
        case 4:
        case 5:
        case 6:
            return len
        case 7:
        case 8:
        case 9:
            return len+2
        case 10:
        case 11:
            return len+3
        case 12:
        case 13:
        case 14:
            return len+4
        default:
            return 4
        }
    }
}
