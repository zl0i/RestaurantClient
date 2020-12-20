import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtGraphicalEffects 1.0

import "./Components"

Item {
    id: _menuPage

    property var basket: Basket.basket

    Rectangle {
        width: parent.width; height: 85
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
            verticalOffset: 4
        }

        SearchItem {
            x: 20; y: 20
            width: parent.width-40; height: 30
            onTextChanged: {
                if(text)
                    _menuModel.fillModel(MenuItems.filterMenuByName(text))
                else
                    _menuModel.fillModel(MenuItems.menu)
            }
        }


        ListView {
            id: _categoriesView
            x: 10; y: parent.height-height
            width: parent.width-10; height: 25
            clip: true
            orientation: Qt.Horizontal
            spacing: 10
            model: MenuItems.getCategoriesMenu()

            highlight: Item {
                width: _categoriesView.currentItem ? _categoriesView.currentItem.width : 0
                height: _categoriesView.currentItem ? _categoriesView.currentItem.height : 0
                Rectangle {
                    id: _highlightItem
                    y: parent.height
                    width:parent.width; height: 4
                    color: "#5AD166"
                    layer.enabled: true
                    layer.effect: DropShadow {
                        radius: 8
                        samples: 16
                        color: "#5AD166"
                        verticalOffset: 4
                    }
                    Behavior on x {
                        NumberAnimation {
                            duration: 250
                        }
                    }
                    Behavior on width {
                        NumberAnimation { duration: 100 }
                    }
                }
            }

            delegate: Label {
                font.pixelSize: 18
                text: modelData
                MouseArea {
                    width: parent.width; height: parent.height
                    onClicked: {
                        _categoriesView.currentIndex = index
                        _menuView.positionViewAtIndex(MenuItems.findIndexMenuByCategory(modelData), ListView.Beginning)
                    }
                }
            }
        }
    }


    ListModel {
        id: _menuModel
        Component.onCompleted: fillModel(MenuItems.menu)

        function fillModel(menu) {
            _menuModel.clear()
            menu.forEach(function (item) {
                _menuModel.append({
                                      "id": item["_id"],
                                      "name": item.name,
                                      "cost": item.cost,
                                      "image": item.image,
                                      "description": item.description,
                                      "category": item.category
                                  })
            })
        }
    }


    onBasketChanged: {
        for(var i = 0; i < _menuView.count; i++) {            
            if(_menuView.itemAtIndex(i))
                _menuView.itemAtIndex(i).count = Basket.getCountById(_menuView.itemAtIndex(i).menu_id)
        }
    }

    SwipeRefreshPage {
        id: _menuContent
        x: 20; y: 85; z:-1
        width: parent.width - 40
        height: parent.height - y
        contentColor: "#5AD166"
        onStartUpdate: {
            AziaAPI.getMenu(
                        function(responseText) {
                            _menuContent.stopRunningUpdate()
                            MenuItems.parseMenu(JSON.parse(responseText))
                            _menuModel.fillModel(MenuItems.menu)
                        },
                        function(error) {

                        })
        }
        ListView {
            id: _menuView
            width: parent.width
            height: parent.height
            bottomMargin: 20
            model: _menuModel
            spacing: -1

            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: Label {
                width: _menuView.width; height: 60
                verticalAlignment: Text.AlignVCenter
                text: section
                font { pixelSize: 18; bold: true }
            }




            delegate: MenuDelegate {
                id: _menuDelegate
                width: _menuView.width; height: 100
                menu_id: model.id
                name: model.name
                image: model.image ? AziaAPI.host + "/" + model.image : ""
                cost: model.cost
                count: Basket.getCountById(menu_id)
                onClicked: {
                    _menuInfo.name = model.name
                    _menuInfo.image = model.image ? AziaAPI.host + "/" + model.image : ""
                    _menuInfo.info = model.description
                    _menuInfo.open()
                }
                onEditedCount: {
                    Basket.setCountItem(MenuItems.menu[index], count)
                }
            }
            onCurrentSectionChanged: _categoriesView.currentIndex = _categoriesView.model.indexOf(currentSection)
        }
    }



    MenuInfoDrawer {
        id: _menuInfo
    }
}
