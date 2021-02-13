import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: _shopPopup
    width: parent.width
    height: 30

    property string shopName
    property var shopModel

    signal selectShop(var id)

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 7
        Label {
            height: 30
            verticalAlignment: Text.AlignVCenter
            font { pixelSize: 20; weight: Font.Bold }
            color: "#393939"
            text: _shopPopup.shopName
        }
        Image {
            y: 11
            width: 15
            height: 8
            source: "qrc:/icons/arrow-down-white.svg"
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: _popup.open()
    }

    Popup {
        id: _popup
        x: 30; y: parent.height+5
        width: parent.width-60
        height: _shopView.height+20
        modal: true; dim: true
        padding: 0
        topPadding: 7
        bottomPadding: 7

        background: Rectangle {
            width: parent.width
            height: parent.height
            radius: 10
            color: "#FFFFFF"
        }

        Overlay.modal: Rectangle { color: "#A0000000" }

        contentItem: Item {
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                color: "#393939"
                text: qsTr("Выберите кафе")
            }
            ListView {
                id: _shopView
                y: 15
                width: parent.width
                height: count*50
                clip: true
                interactive: false
                model: _shopPopup.shopModel

                delegate: Item {
                    width: _shopView.width
                    height: 50
                    Label {
                        x: 25; y: 7
                        font { pixelSize: 20; weight: Font.Bold }
                        color: "#393939"
                        text: modelData.name
                    }
                    Label {
                        x: 25; y: 30
                        font.pixelSize: 12
                        opacity: 0.5
                        color: "#000000"
                        text: modelData.address
                    }

                    MouseArea {
                        width: parent.width
                        height: parent.height
                        onClicked: {
                            _shopPopup.selectShop(modelData.id)
                            _popup.close()
                        }
                    }
                    Rectangle {
                        width: parent.width
                        height: 1
                        opacity: 0.2
                        visible: index !== 0
                        color: "#000000"
                    }
                }
            }
        }
    }
}
