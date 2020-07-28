import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: _addItem
    width: 120; height: 40

    property int count: 0

    signal increment()
    signal decrement()

    Rectangle {
        x: 80
        width: 40; height: 40; radius: 10
        color: "#C4C4C4"
        Label {
            width: parent.width; height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
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
        width: parent.width; height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 24
        color: "#707070"
        text: _addItem.count
    }

    Rectangle {
        width: 40; height: 40; radius: 10
        visible: _addItem.count != 0
        color: "#C4C4C4"
        Label {
            width: parent.width; height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
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
