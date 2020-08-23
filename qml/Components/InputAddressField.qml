import QtQuick 2.12
import QtQuick.Controls 2.12



Row {
    width: parent.width
    height: 40
    spacing: 20

    property alias street: _streetField.text
    property alias house: _houseField.text
    property alias flat: _flatField.text

    InputText {
        id: _streetField
        width: parent.width - 140
        placeholderText: qsTr("Улица")
    }

    InputText {
        id: _houseField
        width: 50
        placeholderText: qsTr("Дом")
        validator: RegExpValidator { regExp: /[1-9]{1,3}[/]{0,1}[0-9]{0,3}[А-я]{0,1}/}
    }

    InputText {
        id: _flatField
        width: 50
        placeholderText: qsTr("Кв.")
        validator: RegExpValidator { regExp: /[1-9]{0,3}/}
    }
}


