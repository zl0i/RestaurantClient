import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.14
import QtGraphicalEffects 1.0

import "./Components"
import AziaData 1.0
import AziaAPI 1.0

Item {
    clip: true
    Rectangle {
        width: parent.width; height: 50
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
            verticalOffset: 4
        }

        Label {
            x: 20;
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            font { pixelSize: 20; bold: true }
            text: qsTr("Корзина")
        }
    }

    Timer {
        id: _tim
        interval: 200
        running: false
        repeat: false
        onTriggered: {
            Basket.basketChanged()
        }
    }

    ListView {
        x: 20; y: 60
        width: parent.width-40; height: parent.height-40
        spacing: -1
        model: Basket.basket
        delegate: BasketDelegate {
            id: _basketDelegate
            width: parent.width; height: 100
            image: "http://localhost:8989/" + modelData.img
            name: modelData.name
            cost: modelData.cost
            count: modelData.count
            onIncrement: {
                Basket.basket[index].count = count
                Basket.basketChanged()
            }
            onDecrement: {
                if(count === 0) {
                    Basket.basket.splice(index, 1)
                } else {
                    Basket.basket[index].count = count
                }

                Basket.basketChanged()
            }
        }
    }

    CustomButton {
        x: 20; y: parent.height - 60
        width: parent.width - 40; height: 40
        visible: Basket.basket.length > 0
        enableShadow: true
        text: qsTr("Оформить заказ")
        extractText: qsTr("%1 р.").arg(Basket.getTotal())
        onClicked: _orderDrawer.open()

    }

    OrderDialog {
        id: _orderDrawer
        phone: User.phoneNumber
        address {
            street: User.address.street
            house: User.address.house
            flat: User.address.flat
        }
        onAccess: {
            var obj = {
                "menu": JSON.stringify(Basket.getMinimumBasket()),
                "comment": _orderDrawer.comment,
                "address": _orderDrawer.address,
                "phone": _orderDrawer.phone,
                "phoneNumber": User.phoneNumber
            }

            AziaAPI.ordered(obj,
                            function(responseText) {
                                console.log(responseText)
                                close()
                            },
                            function (status, text) {
                                console.log("error:", text)
                            })
        }
    }
}
