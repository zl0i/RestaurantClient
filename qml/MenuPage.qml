import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtGraphicalEffects 1.0

import "./Components"

Item {
    id: _menuPage

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
            onTextChanged:  menu.setFilterRegExp(new RegExp(text, 'i'))
        }

        ListView {
            id: _categoriesView
            x: 10; y: parent.height-height
            width: parent.width-15; height: 25
            clip: true
            orientation: Qt.Horizontal
            spacing: 10
            model: menu.categories

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
                }
            }

            delegate: Label {
                font.pixelSize: 18
                text: modelData
                MouseArea {
                    width: parent.width; height: parent.height
                    onClicked: {
                        _categoriesView.currentIndex = index
                        _menuView.positionViewAtIndex(menu.findIndexByCategory(modelData), ListView.Beginning)
                        _categoriesView.positionViewAtIndex(index, ListView.Beginning)
                    }
                }
            }
        }
    }

    SwipeRefreshPage {
        id: _menuContent
        x: 20; y: 85; z:-1
        width: parent.width - 40
        height: parent.height - y
        contentColor: "#5AD166"
        onStartUpdate: core.requestMenu()

        Connections {
            target: core
            function onMenuSended() {
                _menuContent.stopRunningUpdate();
            }
        }

        ListView {
            id: _menuView
            width: parent.width
            height: parent.height
            bottomMargin: 20
            model: menu
            spacing: -1

            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.DragOverBounds

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
                image: model.image ? core.host + "/" + model.image : ""
                cost: model.cost
                count: model.count

                Binding {
                    target: _menuDelegate
                    property: "count"
                    value: model.count
                }

                onClicked: {
                    _menuInfo.name = model.name
                    _menuInfo.image = model.image ? core.host + "/" + model.image : ""
                    _menuInfo.info = model.description
                    _menuInfo.open()
                }
                onEditedCount: menu.setCountItem(Number(index), count)
            }
            onCurrentSectionChanged: _categoriesView.currentIndex = _categoriesView.model.indexOf(currentSection)
        }
    }

    MenuInfoDrawer {
        id: _menuInfo
    }
}
