import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

Window {
    visible: true
    width: 420
    height: 720
    title: "Azia"

    SwipeView {
        id: _swipeView
        width: parent.width; height: parent.height-75
        //interactive: false
        MenuPage {

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
            spacing: (parent.width-220)/4
            NavigationDelegate {
                width: 55; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Меню")
                icon: "qrc:/icons/burger-black.svg"
                onClicked: _swipeView.currentIndex = 0
            }
            NavigationDelegate {
                width: 55; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Корзина")
                icon: "qrc:/icons/shopping-black.svg"
                onClicked: _swipeView.currentIndex = 1
            }
            NavigationDelegate {
                width: 55; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Акции")
                icon: "qrc:/icons/stock-black.svg"
                onClicked: _swipeView.currentIndex = 2
            }
            NavigationDelegate {
                width: 55; height: 55
                iconWidth: 35; iconHeight: 30
                text: qsTr("Профиль")
                icon: "qrc:/icons/profile-black.svg"
                onClicked: _swipeView.currentIndex = 3
            }
        }



    }




}
