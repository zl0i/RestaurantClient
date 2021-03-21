import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _page
    color: "#FFFFFF"

    property alias address: _address
    property alias comment: _comment.text
    property alias phone: _phone.text

    property real costOrder
    property var cityCostDeliveryModel

    signal payment(var obj)
    signal back()

    function reset() {
        _comment.text = ""
        _paymentButton.enabled = true
        _busyPopup.close()
    }

    function verificate() {
        return _phone.text && _address.filled && _city.text
    }

    function close() {
        _busyPopup.close()
        visible = false
    }

    Rectangle {
        z: 1
        width: parent.width
        height: 60
        color: "#FFFFFF"
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
            verticalOffset: 4
        }
        Row {
            x: 20; y: 10
            height: 40
            spacing: 20
            Image {
                y: 10
                width: 20; height: 20
                antialiasing: true
                smooth: true
                source: "qrc:icons/arrowBack-black.svg"
                MouseArea {
                    anchors.fill: parent
                    onClicked: _page.back()
                }
            }
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                font { pixelSize: 18; bold: true }
                text: qsTr("Оформление заказа")
            }
        }
    }

    Flickable {
        y: 60
        width: parent.width
        height: parent.height-y
        contentHeight: _column.height
        topMargin: 30
        leftMargin: 20
        rightMargin: 20
        interactive: _column.height > height
        Column {
            id: _column
            width: parent.width
            spacing: 20
            InputPhoneField {
                id: _phone
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                onAccepted: _address.forceActiveFocus()
            }
            SelectInput {
                id: _city
                width: parent.width
                model: Object.keys(_page.cityCostDeliveryModel)
                text: Object.keys(_page.cityCostDeliveryModel)[0]
                placeholderText: qsTr("Город")
            }
            InputAddressField {
                id: _address
                width: parent.width
                onAccepted: _comment.forceActiveFocus()
            }
            InputText {
                id: _comment
                width: parent.width
                placeholderText: qsTr("Коментарий")
            }
            Item {
                width: parent.width
                height: 1
            }
            Column {
                width: parent.width
                spacing: 15
                RowLayout {
                    width: parent.width
                    height: 20
                    Label {
                        Layout.alignment: Qt.AlignLeft
                        text: qsTr("Стоимость")
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 18; }
                        color: "#393939"
                    }
                    Label {
                        Layout.alignment: Qt.AlignRight
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 18 }
                        color: "#393939"
                        text: qsTr("%1 р.").arg(_page.costOrder)
                    }
                }
                RowLayout {
                    width: parent.width
                    height: 20
                    Label {
                        Layout.alignment: Qt.AlignLeft
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 18 }
                        color: "#393939"
                        text: qsTr("Доставка")
                    }
                    Label {
                        Layout.alignment: Qt.AlignRight
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 18; }
                        color: "#393939"
                        text: qsTr("%1 р.").arg(_page.cityCostDeliveryModel[_city.text] )
                    }
                }
                RowLayout {
                    width: parent.width
                    height: 20
                    Label {
                        Layout.alignment: Qt.AlignLeft
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 20; weight: Font.Bold}
                        color: "#393939"
                        text: qsTr("Итого")
                    }
                    Label {
                        Layout.alignment: Qt.AlignRight
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font { pixelSize: 20; weight: Font.Bold }
                        color: "#393939"
                        text: qsTr("%1 р.").arg(_page.costOrder + (_page.cityCostDeliveryModel[_city.text] ))
                    }
                }
            }
        }
    }

    CustomButton {
        id: _paymentButton
        x: 20
        y: parent.height - height - 20
        width: parent.width-40
        height: 50
        label.font.pixelSize: 22
        text: qsTr("Оплатить")
        onClicked: {
            if(_page.verificate()) {
                var obj = {
                    "comment": _comment.text,
                    "address": {
                        "city": _city.text,
                        "street": _address.street,
                        "house": _address.house,
                        "flat": _address.flat
                    },
                    "phone": _phone.getClearPhoneNumber()
                }
                _page.payment(obj)
                _busyPopup.open()
                _paymentButton.enabled = false
            } else {
                _errorPopup.show(qsTr("Заполните поля телефона и адреса"))
            }
        }
    }

    Popup {
        id: _busyPopup
        parent: Overlay.overlay
        width: parent.width
        height: parent.height

        background: Rectangle {
            width: parent.width
            height: parent.height
            color: "#C0000000"
        }

        contentItem: Item {
            CustomBusyIndicator {
                anchors.centerIn: parent
                width: 100; height: 100
                running: true
            }
        }
    }


}
