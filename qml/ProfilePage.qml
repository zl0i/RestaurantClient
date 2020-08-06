import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import AziaData 1.0
import AziaAPI 1.0

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
        x: 20; y: 60
        width: parent.width- 40; height: parent.height-60
        spacing: 20
        Column {
            spacing: 5
            Label {
                color: "#272727"
                font { pixelSize: 20; bold: true}
                text: qsTr("Здраствуйте %1!").arg(User.firstName)
            }
            Label {
                color: "#272727"
                font { pixelSize: 14}
                text: User.phoneNumber
            }
        }
        Label {
            color: "#272727"
            font { pixelSize: 20; bold: true}
            text: qsTr("Текущий заказ:")
        }
        OrderDelegate {
            status: "processing"
            datetime: User.activeOrder.datetime
            total: User.activeOrder.total
        }
        Label {
            color: "#272727"
            font { pixelSize: 20; bold: true}
            text: qsTr("Предыдущие заказы:")
        }

        ListView {
            width: parent.width
            height: parent.height - 100
            model: User.history
            clip: true
            spacing: 20
            delegate: OrderDelegate {
                status: modelData.status
                datetime: modelData.datetime
                total: modelData.total
            }
        }

    }

}
