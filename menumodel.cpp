#include "menumodel.h"

#include <QSortFilterProxyModel>

MenuModel::MenuModel(QObject *parent) : QStandardItemModel(parent)
{

}

void MenuModel::parseData(QJsonObject obj)
{
    categories.clear();
    QJsonArray cat = obj.value("categories").toArray();
    for(int i = 0; i < cat.size(); i++) {
        categories.append(cat.at(i).toString());
    }
    emit categoriesChanged();

    clear();

    QJsonArray menu = obj.value("menu").toArray();
    insertColumn(0);
    insertRows(0, menu.size());
    for(int i = 0; i < menu.size(); i++) {
        QJsonObject itemJson = menu.at(i).toObject();
        QModelIndex index = this->index(i, 0);
        setData(index, itemJson.value("_id").toString(), IdRole);
        setData(index, itemJson.value("name").toString(), NameRole);
        setData(index, itemJson.value("category"), CategoryRole);
        setData(index, itemJson.value("image"), ImageRole);
        setData(index, itemJson.value("description"), DescriptionRole);
        setData(index, itemJson.value("cost"), CostRole);
    }
}

void MenuModel::setCountItem(int row, int num)
{    
    QModelIndex index = this->index(row, 0);
    setData(index, num, MenuModel::CountRole);
    emit countChanged();
}

void MenuModel::setCountItem(QString id, int num)
{   
    QModelIndex index = indexById(id);
    setData(index, num, MenuModel::CountRole);
    emit countChanged();
}

int MenuModel::findIndexByCategory(QString cat)
{
    for(int i = 0; i < rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        if(data(index, MenuRoles::CategoryRole).toString() == cat) {
            return index.row();
        }
    }
    return 0;
}

QModelIndex MenuModel::indexById(QString id)
{
    for(int i = 0; i < rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        if(data(index, MenuRoles::IdRole).toString() == id) {
            return index;
        }
    }
    return QModelIndex();
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
    roles[CountRole] = "count";
    return roles;
}
