import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Popup {
    id: _popup
    parent: Overlay.overlay
    x: parent.width/2 - width/2
    y: 100
    width: Math.min(parent.width-40, _label.contentWidth+20)
    closePolicy: Popup.NoAutoClose

    property int durationShow: 3000
    property string errorText

    function show(text) {
        errorText = text
        open()
    }

    onOpened: _timer.start()

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 1000
        }
    }


    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: height/2
        color: "#B0000000"
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 16
            samples: 24
            color: "#A0000000"
        }
    }

    contentItem: Label {
        id: _label
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#FFFFFF"
        wrapMode: contentWidth > _popup.width ? Text.WordWrap : Text.NoWrap
        text: _popup.errorText
    }

    Timer {
        id: _timer
        interval: _popup.durationShow
        onTriggered: _popup.close()

    }
}
