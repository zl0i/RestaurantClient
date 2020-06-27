import QtQuick 2.12
import QtQuick.Controls 2.12

TextField {
    id: _field
    height: 50

    onFocusChanged:  {
        if(focus) {
            _animation.to = _field.width
        } else {
            _animation.to = 0
        }
        _animation.start()
    }

    background: Item {
        width: parent.width; height: parent.height
        Rectangle {
            y: parent.height-1
            width: parent.width; height: 2
            color: "#C4C4C4"
        }

        NumberAnimation {
            id: _animation
            target: _line
            property: "width"
            //from: 0
            //to: _field.width
            duration: 250

        }

        Rectangle {
            id: _line
            y: parent.height-1
            height: 2
            color: "#5AD166"
        }

    }
}
