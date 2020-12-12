import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

//import Components 1.0
import "./Components"
import AziaData 1.0
import AziaAPI 1.0
import AjaxLibrary 1.0

ApplicationWindow {
    visible: true
    width: 420
    height: 720
    title: "Azia"

    SwipeView {
        id: _swipeView
        width: parent.width; height: parent.height-60
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
        width: parent.width; height: 60
        color: "#FFFFFF"
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            verticalOffset: -3
            color: "#40000000"
        }
        Row {
            x: 20
            width: parent.width - 40
            height: parent.height
            NavigationDelegate {
                width: parent.width/3; height: parent.height
                iconWidth: 35; iconHeight: 30
                text: qsTr("Меню")
                icon: "qrc:/icons/burger-black.svg"
                selected: _swipeView.currentIndex === 0
                onClicked: _swipeView.currentIndex = 0
            }
            Rectangle {
                y: parent.height/2 - height/2
                width: 2
                height: parent.height - 20
                color: "#5AD166"
            }

            NavigationDelegate {
                width: parent.width/3; height: parent.height
                iconWidth: 30; iconHeight: 25
                text: qsTr("Корзина")
                icon: "qrc:/icons/shopping-black.svg"
                selected: _swipeView.currentIndex === 1
                onClicked: _swipeView.currentIndex = 1
            }
            Rectangle {
                y: parent.height/2 - height/2
                width: 2
                height: parent.height - 20
                color: "#5AD166"
            }
            NavigationDelegate {
                width: parent.width/3; height: parent.height
                iconWidth: 30; iconHeight: 25
                text: qsTr("Профиль")
                icon: "qrc:/icons/profile-black.svg"
                selected: _swipeView.currentIndex === 3
                onClicked: _swipeView.currentIndex = 3
            }
        }
    }

    AuthDialog {
        //visible: true

        onInput: {
            AziaAPI.authentication(obj,
                                   function (responseText) {
                                       close()
                                       var user = JSON.parse(responseText)
                                       User.phoneNumber = obj.phoneNumber
                                       User.firstName = user.info.name
                                       User.address = user.info.address
                                       User.history = user.info.orders.reverse()
                                       User.activeOrder = user.info.activeOrder
                                   },
                                   function (error) {
                                       console.log("error:", error)
                                   })
        }
        onRegistrationClicked: {
            AziaAPI.registration(obj,
                                 function(responseText) {
                                     console.log("registration:", responseText)
                                     close()
                                 },
                                 function (error) {
                                     console.log("error:", error)
                                 })
        }
    }
}
