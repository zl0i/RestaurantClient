#include "basketmodel.h"

BasketModel::BasketModel(MenuModel *menus, QObject *parent) : QSortFilterProxyModel(parent)
{
    setSourceModel(menus);
    connect(this, &BasketModel::dataChanged, this, &BasketModel::calcTotal);
}

bool BasketModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
     QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
     return sourceModel()->data(index, MenuModel::CountRole).toInt() > 0;
}


void BasketModel::calcTotal() {

}
