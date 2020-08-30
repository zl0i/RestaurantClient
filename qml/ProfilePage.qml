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

    SwipeRefreshPage {
        z: -1
        x: 20; y: 60
        width: parent.width- 40; height: parent.height-60
        contentColor: "#5AD166"
        contentHeight: _content.height
        bottomMargin: 20
        onStartUpdate: {
            AziaAPI.getInfo(User.phoneNumber,
                            function(responseText) {
                                var user = JSON.parse(responseText)
                                //User.phoneNumber = obj.phoneNumber
                                User.firstName = user.info.name
                                User.address = user.info.address
                                User.history = user.info.orders.reverse()
                                User.activeOrder = user.info.activeOrder
                                console.log(JSON.stringify(User.activeOrder))
                            },
                            function (error) {
                                console.log("error:", error)
                            })
            stopRunningUpdate()
        }

        Column {
            id: _content
            width: parent.width
            //height: parent.height
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
            Column {
                width: parent.width
                spacing: 20
                visible: Boolean(User.activeOrder)// !== undefined
                Label {
                    color: "#272727"
                    font { pixelSize: 20; bold: true}
                    text: qsTr("Текущий заказ:")
                }
                ActiveOrderDelegate {
                    status: User.activeOrder ? User.activeOrder.status : ""
                    datetime: User.activeOrder ? User.activeOrder.datetime : ""
                    total: User.activeOrder ? User.activeOrder.total : ""
                }
            }
            Label {
                color: "#272727"
                font { pixelSize: 20; bold: true}
                text: qsTr("Предыдущие заказы:")
            }

            Repeater {
                width: parent.width
                height: parent.height - y
                //bottomMargin: 30
                model: User.history
                clip: true
                //spacing: 20
                delegate: OrderDelegate {
                    status: "access"
                    datetime: modelData.datetime
                    total: modelData.cost
                }
            }
        }
    }
}
