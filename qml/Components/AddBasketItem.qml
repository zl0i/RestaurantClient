import QtQuick 2.12
import QtQuick.Controls 2.12

Row {
    id: _addItem
    width: 90; height: 30
    layoutDirection: Qt.RightToLeft

    property int count: 0

    signal increment()
    signal decrement()

    Rectangle {
        width: 30; height: 30; radius: 10
        color: "#C4C4C4"
        Label {
            width: parent.width; height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 18
            color: "#FFFFFF"
            text: "+"
        }
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                _addItem.count += 1
                _addItem.increment()
            }
        }
    }

    Label {
        width:30; height: 30
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        color: "#707070"
        text: _addItem.count
    }

    Rectangle {
        width: 30; height: 30; radius: 10
        visible: _addItem.count != 0
        color: "#C4C4C4"
        Label {
            width: parent.width; height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 18
            color: "#FFFFFF"
            text: "-"
        }
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                _addItem.count -= 1
                _addItem.decrement()
            }
        }
    }
}
