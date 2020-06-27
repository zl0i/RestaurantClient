import QtQuick 2.12
import QtQuick.Controls 2.12


Item {
    id: _delegate
    height: 100
    property string name
    property string image
    property string count


    Image {
        x: 10; y: parent.height/2 - height/2
        width: 80; height: 80
        fillMode: Image.PreserveAspectCrop
        source: _delegate.image
    }

    Label {
        x: 100; y: 10
        text: _delegate.name
    }




}
