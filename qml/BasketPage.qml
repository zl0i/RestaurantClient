import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtGraphicalEffects 1.0

import "./Components"

Item {
    id: _basketPage
    clip: true

    property bool makingOrder: false

    signal checkout()

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

    ListView {
        id: _basketView
        x: 20; y: 60; z: -1
        width: parent.width-40; height: parent.height-40
        bottomMargin: 120
        spacing: -1
        model: basket
        delegate: BasketDelegate {
            id: _basketDelegate
            width: _basketView.width; height: 100
            image: core.host + "/" + model.image
            name: model.name
            cost: model.cost
            count: model.count

            Binding {
                target: _basketDelegate
                property: "count"
                value: model.count
            }
            onIncrement: {
                menu.setCountItem(String(model.id), count)
            }
            onDecrement: {
                menu.setCountItem(String(model.id), count)
            }
        }
        Item {
            width: parent.width
            height: parent.height
            visible: parent.count === 0
            Label {
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font { pixelSize: 18; weight: Font.Bold }
                wrapMode: Text.WordWrap
                text: qsTr("Корзина пока пуста")
            }
        }
    }

    CustomButton {
        x: 20; y: parent.height - 60
        width: parent.width - 40; height: 40
        visible: _basketView.count > 0
        enableShadow: true
        enabled: basket.total >= core.currentShop.minCostDelivery
        text: enabled ? qsTr("Оформить заказ") : qsTr("Минимальная стоимость заказа %1 р.").arg(core.currentShop.minCostDelivery)
        color: enabled ? "#5AD166" : "#949494"
        onClicked: {
            if(user.isAuthenticated) {
                _basketPage.checkout()
            } else {
                _authDialog.open()
                makingOrder = true
            }
        }
    }

    Connections {
        target: core
        function onAuthenticated() {
            if(_basketPage.makingOrder) {
               _basketPage.checkout()
                _basketPage.makingOrder = false
            }
        }
    }
}
