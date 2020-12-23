#include "menumodel.h"

#include <QSortFilterProxyModel>

MenuModel::MenuModel(QObject *parent) : QSortFilterProxyModel(parent)
{
    setSourceModel(&menus);
    setFilterRole(NameRole);   
}

void MenuModel::parseData(QJsonObject obj)
{
    categories.clear();
    QJsonArray cat = obj.value("categories").toArray();
    for(int i = 0; i < cat.size(); i++) {
        categories.append(cat.at(i).toString());
    }
    emit categoriesChanged();

    menus.clear();

    QJsonArray menu = obj.value("menu").toArray();    
    menus.insertColumn(0);
    menus.insertRows(0, menu.size());
    for(int i = 0; i < menu.size(); i++) {
        QJsonObject itemJson = menu.at(i).toObject();
        QModelIndex index = menus.index(i, 0);
        menus.setData(index, itemJson.value("id"), IdRole);
        menus.setData(index, itemJson.value("name"), NameRole);
        menus.setData(index, itemJson.value("category"), CategoryRole);
        menus.setData(index, itemJson.value("image"), ImageRole);
        menus.setData(index, itemJson.value("description"), DescriptionRole);
        menus.setData(index, itemJson.value("cost"), CostRole);
    }   
    qDebug() << menus.rowCount();
}

QHash<int, QByteArray> MenuModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CategoryRole] = "category";
    roles[CostRole] = "cost";
    roles[DescriptionRole] = "description";
    roles[ImageRole] = "image";
    return roles;
}
