#include "activeorder.h"

ActiveOrder::ActiveOrder(QObject *parent) : QStandardItemModel(parent)
{

}

void ActiveOrder::setMenu(MenuModel *menu)
{
    this->menu = menu;
}

void ActiveOrder::parseData(QJsonObject obj)
{
    if(obj.isEmpty())
        return;

    total = obj.value("total").toDouble();
    datetime = obj.value("datetime").toString();
    status = obj.value("status").toString();

    QJsonArray jmenu = obj.value("menu").toArray();


    clear();

    insertColumn(0);
    insertRows(0, jmenu.size());
    for(int i = 0; i < jmenu.size(); i++) {
        QJsonObject item = jmenu.at(i).toObject();
        QModelIndex menuIndex = getIndexMenuItemById(item.value("id").toString());
        QModelIndex index = this->index(i, 0);
        setData(index, item.value("id"), IdRole);
        setData(index, menu->data(menuIndex, MenuModel::NameRole), NameRole);
        setData(index, menu->data(menuIndex, MenuModel::CostRole), CostRole);
        setData(index, item.value("count"), CountRole);
        setData(index, data(index, CountRole).toInt() * data(index, CostRole).toDouble(), TotalRole);
    }

    emit activeOrderChanged();
}

QHash<int, QByteArray> ActiveOrder::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CostRole] = "cost";
    roles[CountRole] = "count";
    roles[TotalRole] = "total";
    return roles;
}

QModelIndex ActiveOrder::getIndexMenuItemById(QString id)
{
    for(int i = 0; i < menu->rowCount(); i++) {
        QModelIndex index = menu->index(i, 0);
        if(menu->data(index, MenuModel::IdRole).toString() == id) {
            return index;
        }
    }
    return QModelIndex();
}
