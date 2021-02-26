import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

InputText {
    id: _input
    readOnly: true

    property var model


    Image {
        x: parent.width - 30
        y: parent.height-18
        width: 15
        height: 8
        source: "qrc:/icons/arrow-down-white.svg"
    }

    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: _popup.open()
    }

    Popup {
        id: _popup
        y: parent.height+4
        width: parent.width
        height: _view.height+20
        topPadding: 10
        bottomPadding: 10

        background: Rectangle {
            radius: 10
            color: "#FFFFFF"
            layer.enabled: true
            layer.effect: DropShadow {
                radius: 8
                samples: 16
                color: "#80000000"
            }
        }

        contentItem: ListView {
            id: _view
            width: parent.width
            height: count*27
            interactive: false
            model: _input.model
            delegate: Label {
                width: _view.width
                height: 27
                verticalAlignment: Text.AlignVCenter
                color: _mouseArea.pressed ? "#5AD166" : "#393939"
                text: modelData
                MouseArea {
                    id: _mouseArea
                    width: parent.width
                    height: parent.height
                    onClicked: {
                        _input.text = modelData
                        _popup.close()
                    }
                }
            }
        }
    }
}
