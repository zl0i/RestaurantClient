import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: _delegate
    width: parent.width; height: 40

    property string status
    property var datetime
    property var total: 0

    function getTextStatus() {
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

    Image {
        width: 40; height: 40
        source: {
            if(_delegate.status === "success") {
                return "qrc:/icons/order-access.svg"
            } else if(_delegate.status === "canceled") {
                return "qrc:/icons/order-canceled.svg"
            }
            return "qrc:/icons/order-processing.svg"
        }
    }
    Column {
        x: 50
        spacing: 3
        Label {
            font.pixelSize: 16
            color: "#494949"
            text: _delegate.status == "success" ||  _delegate.status == "canseled" ? new Date(_delegate.datetime).toLocaleString(Qt.locale(), "dd.MM.yyyy") : getTextStatus()
        }
        Label {
            font.pixelSize: 16
            color: "#494949"
            text: new Date(_delegate.datetime).toLocaleString(Qt.locale(), "hh:mm")
        }
    }
    Label {
        x: parent.width - contentWidth
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        color: "#7D7D7D"
        font { pixelSize: 20; bold: true }
        text: qsTr("%1 р.").arg(_delegate.total)
    }
}
