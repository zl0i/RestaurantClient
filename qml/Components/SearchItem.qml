import QtQuick 2.12
import QtQuick.Controls 2.12

TextField {
    width: parent.width; height: parent.height
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
    leftPadding: 20
    placeholderText: qsTr("Поиск")
    placeholderTextColor: "#292929"
    color: "#292929"
    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
        color: "#C4C4C4"
    }

}
