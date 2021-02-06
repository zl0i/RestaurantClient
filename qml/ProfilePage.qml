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
        width: parent.width
        anchors.centerIn: parent
        visible: !user.isAuthenticated
        spacing: 20
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font { pixelSize: 18; weight: Font.Bold }
            wrapMode: Text.WordWrap
            text: qsTr("Войдите в профиль, чтобы увидеть историю покупок")
        }
        CustomButton {
            x: parent.width/2 - width/2
            text: qsTr("Войти")
            onClicked: _authDialog.open()
        }
    }

    SwipeRefreshPage {
        id: _swipePage
        z: -1
        x: 20; y: 60
        width: parent.width-40; height: parent.height-60
        contentColor: "#5AD166"
        contentHeight: _content.height
        bottomMargin: 20
        enabled: user.isAuthenticated
        onStartUpdate: {
            core.updateUserInfo();
        }

        Connections {
            target: core
            function onUserInfoSended() {
                _swipePage.stopRunningUpdate()
            }
        }

        Column {
            id: _content
            width: parent.width
            spacing: 20
            visible: user.isAuthenticated
            Item {
                width: parent.width
                height: 50
                Column {
                    spacing: 5
                    Label {
                        color: "#272727"
                        font { pixelSize: 20; bold: true}
                        text: qsTr("Здраствуйте %1!").arg(user.name)
                    }
                    Label {
                        color: "#272727"
                        font { pixelSize: 14}
                        text: user.phone
                    }
                }
                Image {
                    x: parent.width-width-5; y: parent.height/2 - height/2
                    width: 25
                    height: 25
                    source: "qrc:/icons/logout-black.svg"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: _logoutDialog.open()
                    }
                }
            }
            Column {
                width: parent.width
                spacing: 20
                visible: activeOrder.isEmpty
                Label {
                    color: "#272727"
                    font { pixelSize: 20; bold: true}
                    text: qsTr("Текущий заказ:")
                }
                OrderDelegate {
                    enableExpand: true
                    statusOrder:  activeOrder.status
                    datetime: activeOrder.datetime
                    total: activeOrder.total
                    menu: activeOrder
                    onPayment: core.openPaymentForm()
                }
            }
            Label {
                color: "#272727"
                font { pixelSize: 20; bold: true}
                visible: _repeater.count > 0
                text: qsTr("Предыдущие заказы:")
            }
            Column {
                width: parent.width
                spacing: 10
                Repeater {
                    id: _repeater
                    model: user.orders
                    visible: count > 0
                    clip: true
                    delegate: OrderDelegate {
                        statusOrder: model.status
                        datetime: model.datetime
                        total: model.cost
                    }
                }
            }

            Item {
                width: parent.width
                height: _swipePage.height-y
                visible: _repeater.count == 0
                Label {
                    width: parent.width
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font { pixelSize: 18; weight: Font.Bold }
                    wrapMode: Text.WordWrap
                    text: qsTr("История заказов пока что пуста")
                }
            }
        }
    }

    LogoutDialog {
        id: _logoutDialog
        onLogout: core.logout()
    }
}
