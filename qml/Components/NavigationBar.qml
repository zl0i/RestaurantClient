import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _bar
    width: parent.width; height: 60
    color: "#FFFFFF"
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        verticalOffset: -3
        color: "#40000000"
    }

    property int currentIndex: -1
    signal selected(var index)


    Row {
        x: 20
        width: parent.width - 40
        height: parent.height
        NavigationDelegate {
            width: parent.width/3; height: parent.height
            iconWidth: 35; iconHeight: 30
            text: qsTr("Меню")
            icon: "qrc:/icons/burger-black.svg"
            selected: _bar.currentIndex === 0
            onClicked: _bar.selected(0)
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
            selected: _bar.currentIndex === 1
            onClicked:  _bar.selected(1)
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
            selected: _bar.currentIndex === 2
            onClicked:  _bar.selected(2)
        }
    }
}
