import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

//import Components 1.0
import "./Components"
import AziaData 1.0
import AziaAPI 1.0

Window {
    visible: true
    width: 420
    height: 720
    title: "Azia"

    SwipeView {
        id: _swipeView
        width: parent.width; height: parent.height-75
        clip: true
        MenuPage {
            id: _menuPage
        }

        BasketPage {

        }

        EventPage {

        }

        ProfilePage {

        }

    }

    Rectangle {
        y: parent.height-height
        width: parent.width; height: 75
        color: "#FFFFFF"
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            verticalOffset: -4
            color: "#80000000"
        }
        Row {
            x: 20; y: parent.height/2-height/2
            spacing: (parent.width-340)/4
            NavigationDelegate {
                width: 80; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Меню")
                icon: "qrc:/icons/burger-black.svg"
                selected: _swipeView.currentIndex === 0
                onClicked: _swipeView.currentIndex = 0
            }
            NavigationDelegate {
                width: 80; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Корзина")
                icon: "qrc:/icons/shopping-black.svg"
                selected: _swipeView.currentIndex === 1
                onClicked: _swipeView.currentIndex = 1
                Rectangle {
                    x: parent.width - 50
                    y: parent.height - height - 20
                    width: 55; height: 16; radius: 8
                    color: "#5AD166"
                    visible: total > 0
                    property int total: Basket.getTotal()
                    Label {
                        width: parent.width; height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "#FFFFFF"
                        text: parent.total + " р."
                    }
                }
            }
            NavigationDelegate {
                width: 80; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Акции")
                icon: "qrc:/icons/stock-black.svg"
                selected: _swipeView.currentIndex === 2
                onClicked: _swipeView.currentIndex = 2
            }
            NavigationDelegate {
                width: 80; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Профиль")
                icon: "qrc:/icons/profile-black.svg"
                selected: _swipeView.currentIndex === 3
                onClicked: _swipeView.currentIndex = 3
            }
        }
    }

    AuthDialog {
        visible: true

        onInput: {
            console.log("auth")
            AziaAPI.authentication(obj,
                                   function (responseText) {
                                       close()
                                       Data.phoneNumber = obj.phoneNumber
                                   },
                                   function () {
                                       console.log("error")
                                   })
        }
        onRegistrationClicked: {
            AziaAPI.registration(obj,
                                 function() {
                                     console.log("registr")
                                     close()
                                 },
                                 function () {
                                     console.log("error registr")
                                 })
        }
    }
}
