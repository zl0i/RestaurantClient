#include "basketmodel.h"

BasketModel::BasketModel(MenuModel *menus, QObject *parent) : QSortFilterProxyModel(parent)
{
    setSourceModel(menus);
    connect(menus, &MenuModel::countChanged, this, &BasketModel::calcTotal);
}

QJsonArray BasketModel::order()
{
    QJsonArray arr;    

    for(int i = 0; i < this->rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        QJsonObject item;
        item.insert("id", data(index, MenuModel::IdRole).toJsonValue());
        item.insert("count", data(index, MenuModel::CountRole).toJsonValue());
        arr.append(item);
    }
    return arr;
}

void BasketModel::clearBasket()
{
    for(int i = rowCount()-1; i >= 0; i--) {
        QModelIndex index = this->index(i, 0);
        setData(index, 0, MenuModel::CountRole);       
    }
}

bool BasketModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    return sourceModel()->data(index, MenuModel::CountRole).toInt() > 0;
}

void BasketModel::calcTotal() {
    total = 0;
    for(int i = 0; i < rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        total += data(index, MenuModel::CountRole).toInt() * data(index, MenuModel::CostRole).toInt();
    }
    emit totalChanged();
}
