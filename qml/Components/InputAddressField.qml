import QtQuick 2.12
import QtQuick.Controls 2.12



Row {
    id: _field
    width: parent.width
    height: 40
    spacing: 20

    property alias street: _streetField.text
    property alias house: _houseField.text
    property alias flat: _flatField.text
    readonly property bool filled: _streetField.text &&
                          _houseField.text &&
                          _flatField.text

    signal accepted()

    InputText {
        id: _streetField
        width: parent.width - 140
        placeholderText: qsTr("Улица")
        focus: _field.focus
        onAccepted: _houseField.forceActiveFocus()
    }

    InputText {
        id: _houseField
        width: 50
        placeholderText: qsTr("Дом")
        validator: RegExpValidator { regExp: /[1-9]{1,3}[/]{0,1}[0-9]{0,3}[А-я]{0,1}/}
        onAccepted: _flatField.forceActiveFocus()
    }

    InputText {
        id: _flatField
        width: 50
        placeholderText: qsTr("Кв.")
        validator: RegExpValidator { regExp: /[1-9]{0,3}/}
        onAccepted: _field.accepted()
    }
}


