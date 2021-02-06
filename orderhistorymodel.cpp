#include "orderhistorymodel.h"

OrderHistoryModel::OrderHistoryModel(QObject *parent) : QStandardItemModel(parent)
{

}

void OrderHistoryModel::parseData(QJsonArray arr)
{
    clearModel();

    insertColumn(0);
    insertRows(0, arr.size());
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject itemJson = arr.at(i).toObject();
        QModelIndex index = this->index(i, 0);
        setData(index, itemJson.value("id").toString(), IdRole);
        setData(index, itemJson.value("status").toString(), StatusRole);
        setData(index, itemJson.value("datetime").toString(), DatetimeRole);
        setData(index, itemJson.value("cost"), CostRole);
    }
    emit dataChanged(index(0,0), index(arr.size()-1, 0));
}

void OrderHistoryModel::clearModel()
{
    removeColumn(0);
    removeRows(0, rowCount());
}

QHash<int, QByteArray> OrderHistoryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[StatusRole] = "status";
    roles[DatetimeRole] = "datetime";
    roles[CostRole] = "cost";
    return roles;
}
