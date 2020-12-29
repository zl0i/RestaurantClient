import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import "./Components"

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
            text: qsTr("Профиль")
        }
    }


    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - height - 120
        spacing: 10
        Label {
            height: 35
            font {
                pixelSize: 24
                bold: true
            }
            text: qsTr("Здравствуйте %1!").arg(user.name)
        }
        Label {
            height: 35
            font {
                pixelSize: 24
                bold: true
            }
            text: qsTr("Активный заказ")
            MouseArea {
                anchors.fill: parent
                onClicked: console.log("active order")
            }
        }
        Label {
            height: 35
            font {
                pixelSize: 24
                bold: true
            }
            text: qsTr("История")
            MouseArea {
                anchors.fill: parent
                onClicked: console.log("history")
            }
        }
        Label {
            height: 35
            font {
                pixelSize: 24
                bold: true
            }
            text: qsTr("Профиль")
            MouseArea {
                anchors.fill: parent
                onClicked: console.log("profile")
            }
        }
        Label {
            height: 35
            font {
                pixelSize: 24
                bold: true
            }
            text: qsTr("Выход")
            MouseArea {
                anchors.fill: parent
                onClicked: console.log("logout")
            }
        }
    }
}
