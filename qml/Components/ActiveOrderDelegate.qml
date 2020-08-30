import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: _delegate
    width: parent.width; height: 40

    property string status
    property var datetime
    property var total: 0

    function getTextStatus() {
        if(status === "accepted")
            return qsTr("Готовится")
        else if(status === "delivery")
            return qsTr("Уже в пути")
        return qsTr("Принят")
    }

    Image {
        width: 40; height: 40
        source: {
            if(_delegate.status === "access") {
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
            text: getTextStatus()
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
