#include "basketmodel.h"

BasketModel::BasketModel(MenuModel *menus, QObject *parent) : QSortFilterProxyModel(parent)
{
    setSourceModel(menus);
    connect(menus, &MenuModel::countChanged, this, &BasketModel::calcTotal);
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
