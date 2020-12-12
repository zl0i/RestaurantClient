#include "menuitems.h"

MenuItems::MenuItems(QObject *parent) : QAbstractListModel(parent)
{

}

void MenuItems::parseData(QJsonArray)
{

}


int MenuItems::rowCount(const QModelIndex &) const
{
    return menus.count();
}

QVariant MenuItems::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > menus.count())
        return QVariant();

    const MenuItem &item = menus[index.row()];
    switch (role) {
    case IdRole:
        return item.id;
    case NameRole:
        return item.name;
    case CategoryRole:
        return item.category;
    case CostRole:
        return item.cost;
    case DescriptionRole:
        return item.description;
    case ImageRole:
        return item.imageUrl;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MenuItems::roleNames() const
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
