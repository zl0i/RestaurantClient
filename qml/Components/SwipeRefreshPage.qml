import QtQuick 2.12
import QtQuick.Controls 2.5

Flickable {
    id: _root

    flickableDirection: Flickable.VerticalFlick
    boundsMovement: Flickable.StopAtBounds
    boundsBehavior: Flickable.DragOverBounds
    height: parent.height


    readonly property alias runningUpdate: _swipe.updateRunnig
    property alias enabledUpdate: _swipe.enabledUpdate
    property alias speed: _swipe.speed
    property alias contentColor: _swipe.contentColor
    property alias backgroundColor: _swipe.backgroundColor

    signal startUpdate

    function stopRunningUpdate() {
        _swipe.stopUpdate()
    }




    SwipeRefreshLayout {
        id: _swipe
        parentHeight: _root.height
        parentOvershoot: -_root.verticalOvershoot
        pressed: _root.dragging
        speed: 0.8
        onUpdateStart: _root.startUpdate()
    }

}

