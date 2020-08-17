import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegate
    width: parent.width
    height: 200
    radius: 10
    color: "#FFFFFF"
    layer.enabled: true
    layer.effect: DropShadow {
        samples: 16
        radius: 8
        color: "#80000000"
    }

    property string image: ""
    property string text: ""

    Image {
        width: parent.width
        height: parent.height-40
        fillMode: Image.PreserveAspectCrop
        source: _delegate.image
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: _delegate.width
                height: _delegate.height - 40
                radius: 10
            }
        }
    }

    Label {
        y: parent.height - height
        width: parent.width
        height: 40
        leftPadding: 20
        rightPadding: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        color: "#000000"
        text: _delegate.text
    }
}
