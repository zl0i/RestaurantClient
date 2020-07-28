pragma Singleton
import QtQuick 2.12

QtObject {
    id: _root
    property var menu: []

    function findIndexMenuByCategory(category) {
        return menu.findIndex(function(item) {
            if(item.category === category)
                return true
        })
    }

    function getCategoriesMenu() {
        var cat = [];
        menu.forEach(function (item) {
           if(cat.indexOf(item.category) === -1)
               cat.push(item.category)
        })
        return cat
    }

    function filterMenuByName(str) {
        var reg = new RegExp(str, "i")
        return menu.filter(function(item) {
            if(reg.test(item.name))
                return true
        })
    }

    function parseMenu(data) {
        _root.menu = []
        data.forEach(function (item) {
            _root.menu.push(item)
        })
        menuChanged()
    }
}
