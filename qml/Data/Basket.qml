pragma Singleton
import QtQuick 2.0

QtObject {

    property var basket: []

    function getMinimumBasket() {
        var arr = []
        basket.forEach(function(item){
            arr.push({
                        "_id": item._id,
                         "count": item.name
                     })
        })
        return arr
    }

    function add(menuItem) {
        var index = basket.findIndex(function(item) {
            if(item["_id"] === menuItem["_id"])
                return true
        })
        if(index === -1) {
            menuItem.count = 1
            basket.push(menuItem)
        } else {
            basket[index].count += 1
        }
        basketChanged()
    }

    function decrease(menuItem) {
        var index = basket.findIndex(function(item) {
            if(item["_id"] === menuItem["_id"])
                return true
        })
        if(index >= 0) {
            if(basket[index].count === 1) {
                basket.slice(index, 1)
            } else {
                basket[index].count -= 1
            }
        }
        basketChanged()
    }

    function setCountItem(menuItem, count) {
        var index = basket.findIndex(function(item) {
            if(item["_id"] === menuItem["_id"])
                return true
        })

        if(index >= 0) {
            if(count === 0) {
                basket.splice(index, 1)
            } else {
                basket[index].count = count
            }
        } else {
            menuItem.count = count
            basket.push(menuItem)
        }
        basketChanged()
    }

    function getCountById(id) {

        var index = -1
        for(var i = 0; i < basket.length; i++) {
            if(basket[i]["_id"] === id) {
                index = i
                break
            }
        }

        if(index === -1)
            return 0

        return basket[index].count
    }

    function getTotal() {
        var sum = 0
        basket.forEach(function(item){
            sum += item.count * item.cost
        })
        return sum
    }
}
