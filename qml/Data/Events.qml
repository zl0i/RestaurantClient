pragma Singleton
import QtQuick 2.12

QtObject {
    id: _root
    property var events: []

    function parse(arr) {
        events = []
        arr.forEach(function (event) {
            _root.events.push(event)
        })
        eventsChanged()
    }

}
