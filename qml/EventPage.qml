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
            text: qsTr("Акции")
        }
    }

    SwipeRefreshListView {
        id: _eventsView
        y: 50; z:-1
        width: parent.width
        height: parent.height - y
        topMargin: 20
        leftMargin: 20
        rightMargin: 20
        bottomMargin: 20
        model: 0
        spacing: 20
        contentColor: "#5AD166"

        delegate: EventDelegate {
            id: _menuDelegate
            width: _eventsView.width-40
            image: core.host + "/" + model.image
            text: model.text
        }
    }
}
