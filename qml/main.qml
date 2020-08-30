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
            x: parent.width/2 - width/2
            y: parent.height/2-height/2
            spacing: 20
            NavigationDelegate {
                width: 50; height: 45
                iconWidth: 30; iconHeight: 25
                text: qsTr("Меню")
                icon: "qrc:/icons/burger-black.svg"
                selected: _swipeView.currentIndex === 0
                onClicked: _swipeView.currentIndex = 0
            }
            NavigationDelegate {
                width: 50; height: 45
               iconWidth: 30; iconHeight: 25
                text: qsTr("Корзина")
                icon: "qrc:/icons/shopping-black.svg"
                selected: _swipeView.currentIndex === 1
                onClicked: _swipeView.currentIndex = 1
                Rectangle {
                    x: parent.width - 30
                    y: parent.height - height - 20
                    width: _label.contentWidth + 10; height: 16; radius: 8
                    color: "#5AD166"
                    visible: total > 0
                    property int total: Basket.getTotal()
                    Label {
                        id: _label
                        width: parent.width; height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "#FFFFFF"
                        font.pixelSize: 10
                        text: qsTr("%1 р.").arg(parent.total)
                    }
                }
            }
            NavigationDelegate {
                width: 50; height: 45
                iconWidth: 30; iconHeight: 25
                text: qsTr("Акции")
                icon: "qrc:/icons/stock-black.svg"
                selected: _swipeView.currentIndex === 2
                onClicked: _swipeView.currentIndex = 2
            }
            NavigationDelegate {
                width: 50; height: 45
                iconWidth: 30; iconHeight: 25
                text: qsTr("Профиль")
                icon: "qrc:/icons/profile-black.svg"
                selected: _swipeView.currentIndex === 3
                onClicked: _swipeView.currentIndex = 3
            }
            NavigationDelegate {
                width: 50; height: 45
                iconWidth: 30; iconHeight: 25
                text: qsTr("ХЗ")
                icon: "qrc:/icons/profile-black.svg"
                selected: _swipeView.currentIndex === 4
                onClicked: _swipeView.currentIndex = 4
            }
        }
    }

    AuthDialog {
        visible: true

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
                                       console.log(JSON.stringify(User.activeOrder))
                                   },
                                   function (error) {
                                       console.log("error:", error)
                                   })
        }
        onRegistrationClicked: {
            AziaAPI.registration(obj,
                                 function() {
                                     console.log("registr")
                                     close()
                                 },
                                 function (error) {
                                     console.log(error)
                                 })
        }
    }
}
