import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.15
import QtGraphicalEffects 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: 20; y: parent.height/2 - height/2
    width: parent.width-40; height: 150
    modal: true; dim: true
    padding: 0
    clip: true

    signal logout()

    Overlay.modal: Rectangle {
        color: "#A0000000"
    }

    background: Rectangle { radius: 10 }

    contentItem: Item {
        Label {
            y: 20
            width: parent.width            
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            leftPadding: 20
            rightPadding: 20
            font.pixelSize: 20
            wrapMode: Text.WordWrap
            color: "#202020"
            text: qsTr("Вы действительно хотите выйти из профиля?")
        }

        Row {
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 20
            CustomButton {
                text: qsTr("Отмена")
                onClicked: _dialog.close()
            }
            CustomButton {
                color: "#949494"
                text: qsTr("Выйти")
                onClicked: {
                    _dialog.close()
                    _dialog.logout()
                }
            }
        }
    }
}
