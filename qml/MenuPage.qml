import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import AziaData 1.0

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
                    width: _categoriesView.currentItem.width; height: 4
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
                        //console.log(modelData, Data.findIndexMenuByCategory(modelData))
                        var indexMenu = Data.findIndexMenuByCategory(modelData)

                        //_menuView.currentIndex = indexMenu


                        //var item = _menuView.itemAtIndex(indexMenu)
                        //_anim.to = item.xy
                        //_anim.start()

                        //var item = _menuView.itemAtIndex(Data.findIndexMenuByCategory(modelData))
                        //console.log(item.x, item.y)
                        //_anim.to = y-50
                        //_anim.start()
                        _menuView.positionViewAtIndex(Data.findIndexMenuByCategory(modelData), ListView.Beginning)
                    }
                }
            }
        }
    }


    ListModel {
        id: _model
        Component.onCompleted: fillModel()
    }

    function fillModel() {
        Object.keys(Data.menu).forEach(function (categories) {

            Data.menu[categories].forEach(function (item) {
                _model.append({
                                  "name": item.name,
                                  "category": categories
                              })
            })
        })
    }

    ListView {
        id: _menuView
        x: 20; y: 90
        width: parent.width - 40
        height: parent.height - y
        clip: true
        model: _model
        SmoothedAnimation {
            id: _anim
            target: _menuView
            property: "contentY"
            velocity: 1000
            to: 0
        }
        section.property: "category"
        section.criteria: ViewSection.FullString
        section.delegate: Label {
            width: _menuView.width; height: 70
            verticalAlignment: Text.AlignVCenter
            text: section
            font { pixelSize: 18; bold: true }
        }

        delegate: MenuDelegate {
            width: _menuView.width; height: 80
            name: model.name
        }

        onCurrentSectionChanged: _categoriesView.currentIndex = Object.keys(Data.menu).indexOf(currentSection)
    }
}
