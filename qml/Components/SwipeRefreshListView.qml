import QtQuick 2.12
import QtQuick.Controls 2.4

ListView {
    id: _root
    signal startUpdate

    readonly property alias runningUpdate: _swipe.updateRunnig
    property alias enabledUpdate: _swipe.enabledUpdate
    property alias speed: _swipe.speed
    property alias contentColor: _swipe.contentColor
    property alias backgroundColor: _swipe.backgroundColor

    function stopRunningUpdate() {
        _swipe.stopUpdate()
    }

    clip: true
    boundsMovement: Flickable.StopAtBounds
    boundsBehavior: Flickable.DragOverBounds

    SwipeRefreshLayout {
        id: _swipe        
        parentHeight: _root.height
        parentOvershoot: -_root.verticalOvershoot
        pressed: _root.dragging
        speed: 0.8
        onUpdateStart: _root.startUpdate()

    }
}
