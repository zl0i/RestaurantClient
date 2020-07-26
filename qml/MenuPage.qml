import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import AziaData 1.0

import "./Components"

Item {
    id: _menuPage
    Rectangle {
        width: parent.width; height: 80
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
            verticalOffset: 4
        }

        SearchItem {
            x: 20; y: 10
            width: parent.width-40; height: 30
            onTextChanged: {
                if(text)
                    fillModel(Data.filterMenuByName(text))
                else
                    fillModel(Data.menu)
            }
        }


        ListView {
            id: _categoriesView
            x: 10; y: parent.height-height
            width: parent.width-10; height: 25
            clip: true
            orientation: Qt.Horizontal
            spacing: 10
            model: Data.getCategoriesMenu()

            highlight: Item {
                width: _categoriesView.currentItem.width; height: _categoriesView.currentItem.height
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
                        _menuView.positionViewAtIndex(Data.findIndexMenuByCategory(modelData), ListView.Beginning)
                    }
                }
            }
        }
    }


    ListModel {
        id: _menuModel
        Component.onCompleted: fillModel(Data.menu)
    }

    function fillModel(menu) {
        _menuModel.clear()
        menu.forEach(function (item) {
            _menuModel.append({
                                  "name": item.name,
                                  "cost": item.cost,
                                  "image": item.img,
                                  "description": item.description,
                                  "category": item.category
                              })
        })
    }

    SwipeRefreshListView {
        id: _menuView
        x: 20; y: 90
        width: parent.width - 40
        height: parent.height - y
        clip: true
        model: _menuModel
        contentColor: "#5AD166"
        section.property: "category"
        section.criteria: ViewSection.FullString
        section.delegate: Label {
            width: _menuView.width; height: 70
            verticalAlignment: Text.AlignVCenter
            text: section
            font { pixelSize: 18; bold: true }
        }
        onStartUpdate: {
            console.log("update menu")
        }

        delegate: MenuDelegate {
            width: _menuView.width; height: 80
            name: model.name
            image: "qrc:/icons/burger-black.svg"
            onClicked: {
                _menuInfo.name = model.name
                _menuInfo.image = "qrc:/icons/burger-black.svg"//model.image
                _menuInfo.info = model.description
                _menuInfo.open()
            }
        }

        onCurrentSectionChanged: _categoriesView.currentIndex = _categoriesView.model.indexOf(currentSection)
    }

    MenuInfoDrawer {
        id: _menuInfo
    }
}
