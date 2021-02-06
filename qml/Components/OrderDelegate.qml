import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: _delegate
    width: parent.width
    height: expand ? 45+_menuView.height : 40
    color: getColorByStatus()
    radius: 5

    property bool enableExpand: false
    property bool expand: false
    property var menu
    property string status
    property var datetime
    property var total: 0

    signal payment()
    signal cancelOrder()

    function getTextByStatus() {
        switch (status) {
        case 'wait_payment':
            return qsTr("Ожидает оплаты")
        case 'accepted':
            return qsTr("Принят")
        case 'coocking':
            return qsTr("Готовится")
        case 'delivering':
            return qsTr("Уже в пути")
        case 'success':
            return qsTr("Готов")
        case 'canseled':
            return qsTr("Отменен")
        }
        return qsTr("Неизвесно")
    }

    function isCancelldOrder() {
        switch (status) {
        case 'wait_payment':
        case 'accepted':
        case 'coocking':
            return true
        }
        return false
    }

    function getColorByStatus() {
        switch (status) {
        case 'wait_payment':
        case 'accepted':
        case 'coocking':
        case 'delivering':
            return "#80F2F26B"
        case 'success':
            return "#8090DB4E"
        case 'canseled':
            return "#80DB4E4E"
        }
        return "#80F2F26B"
    }

    Behavior on height {
        NumberAnimation { duration: 100 }
    }

    MouseArea {
        width: parent.width
        height: parent.height
        enabled: _delegate.enableExpand
        onClicked: _delegate.expand = !_delegate.expand
    }

    Item {
        width: parent.width
        height: 40
        Image {
            x: 10; y: parent.height/2 - height/2
            width: 30; height: 30
            source: "qrc:/icons/box-white.svg"
        }
        Column {
            x: 50
            Label {
                font.pixelSize: 16
                color: "#494949"
                text: _delegate.status == "success" ||  _delegate.status == "canseled" ? new Date(_delegate.datetime).toLocaleString(Qt.locale(), "dd.MM.yyyy") : getTextByStatus()
            }
            Label {
                font.pixelSize: 16
                color: "#494949"
                text: new Date(_delegate.datetime).toLocaleString(Qt.locale(), "hh:mm")
            }
        }
        Row {
            x: parent.width - width-5
            height: parent.height
            spacing: 5
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: "#7D7D7D"
                font { pixelSize: 20; bold: true }
                text: qsTr("%1 р.").arg(_delegate.total)
            }
            Image {
                y: parent.height/2 - height/2
                width: 15
                height: 8
                visible: _delegate.enableExpand
                rotation: _delegate.expand ? 0 : -90
                source: "qrc:/icons/arrow-down-white.svg"

                Behavior on rotation {
                    NumberAnimation { duration: 100 }
                }
            }
        }
    }


    Column {
        id: _menuView
        x: 25; y: 45
        width: parent.width-50
        visible: _delegate.expand
        spacing: 5
        Repeater {
            model: _delegate.menu
            delegate: Item {
                width: _menuView.width
                height: 25
                Label {
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: model.name
                }
                Label {
                    x: parent.width-contentWidth
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("%1 р.").arg(model.total)
                }
            }
        }
        Item {
            width: parent.width
            height: 10
        }

        Row {
            x: parent.width/2 - width/2
            spacing: 30
            Label {
                font { pixelSize: 20; weight: Font.Bold }
                color: "#DB6C6C"
                visible: _delegate.isCancelldOrder()
                text: qsTr("Отменить")
                MouseArea {
                    width: parent.width
                    height: parent.height
                    onClicked: _delegate.cancelOrder()
                }
            }
            Label {
                font { pixelSize: 20; weight: Font.Bold }
                color: "#6FEE6B"
                visible: _delegate.status == "wait_payment"
                text: qsTr("Оплатить")
                MouseArea {
                    width: parent.width
                    height: parent.height
                    onClicked: _delegate.payment()
                }
            }
        }
        Item {
            width: parent.width
            height: 10
        }
    }
}
