import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

import "./Components"

ApplicationWindow {
    visible: true
    width: 420
    height: 720
    title: "Azia"

    font.family: "Roboto"

    property alias errorPopup: _errorPopup

    Item {
        width: parent.width
        height: parent.height
        SwipeView {
            id: _swipeView
            width: parent.width; height: parent.height-60
            clip: true

            MenuPage {
                id: _menuPage
            }

            BasketPage {
                onCheckout: {
                    _orderPage.reset()
                    _orderPage.visible = true
                }
            }

            ProfilePage {

            }
        }
        NavigationBar {
            y: parent.height-height
            currentIndex: _swipeView.currentIndex
            onSelected: {
                switch (index) {
                case 0:
                case 1:
                    _swipeView.currentIndex = index
                    break;
                case 2:
                    _swipeView.currentIndex = 2
                    if(!user.isAuthenticated) {
                        _authDialog.open()

                    }
                    break;
                }
            }
        }
    }

    OrderPage {
        id: _orderPage
        width: parent.width
        height: parent.height
        visible: false
        phone: user.phone
        costOrder: basket.total
        cityCostDeliveryModel: core.currentShop.deliveryCityCost
        address {
            street: user.address.street;
            house: user.address.house;
            flat: user.address.flat;
        }
        onPayment: core.makeOrder(obj)
        onBack: _orderPage.visible = false
    }

    Connections {
        target: core
        function onAuthenticated() {
            _authDialog.close()
        }

        function onError(msg) {
            _errorPopup.show(msg)
        }

        function onPayment(html) {
            _paymentPage.open(html)
        }
    }

    PaymentPage {
        id: _paymentPage
        visible: false
        onBack: close()
        onError: _errorPopup.show(text)

        Connections {
            target: core

            function onPayment(html) {               
                _paymentPage.open(html)
                _orderPage.close()
            }
        }
    }

    AuthDialog {
        id: _authDialog
        phone: user.phone
        onInputPhone: core.inputByPhone(phone)
        onInputCode: core.loginBySMS(code)
    }

    ErrorPopup {
        id: _errorPopup
    }
}
