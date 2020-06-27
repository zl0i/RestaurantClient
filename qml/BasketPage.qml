import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {

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
            text: qsTr("Корзина")
        }
    }

//    ListView {
//        x: 20; y: 20
//        width: parent.width-40; height: parent.height-40
//        spacing: 20
//        model: 5
//        delegate: Rectangle {
//            width: parent.width; height: 150
//            Rectangle {
//                width: 100; height: parent.height
//                color: "#000080"
//            }
//        }
//    }


}
