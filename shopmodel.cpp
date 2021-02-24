#include "shopmodel.h"

ShopModel::ShopModel(QObject *) : QAbstractListModel()
{

}

int ShopModel::rowCount(const QModelIndex &) const
{
    return shops.length();
}

QVariant ShopModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= shops.length())
        return QVariant();

    switch (role) {
    case IdRole:
        return shops[index.row()]->id;
    case NameRole:
        return shops[index.row()]->name;
    case AddressRole:
        return shops[index.row()]->address;
    case StatusRole:
        return shops[index.row()]->status;
    case MinCostDeliveryRole:
        return shops[index.row()]->minCostDelivery;
    case DeliveryCityCostRole:
        return shops[index.row()]->deliveryCityCost;
    }

    return QVariant();
}

void ShopModel::parseData(QJsonArray arr)
{
    emit beginResetModel();
    clearModel();
    emit endResetModel();

    emit beginInsertRows(QModelIndex(), 0, arr.size()-1);
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject obj = arr.at(i).toObject();
        Shop *shop = new Shop();
        shop->id = obj.value("_id").toString();
        shop->name = obj.value("name").toString();
        shop->address = obj.value("address").toString();
        shop->status = obj.value("status").toString();
        shop->minCostDelivery = obj.value("min_cost_delivery").toInt();
        shop->deliveryCityCost = obj.value("delivery_city_cost").toObject();
        MenuModel *menu = new MenuModel();
        menu->parseData(obj.value("items").toObject());
        shop->menu = menu;
        shops.append(shop);
    }
    emit endInsertRows();
    QModelIndex topLeft = index(0,0);
    QModelIndex bottomRight = index(shops.length()-1, 0);
    QVector<int> vectorRole { IdRole, NameRole, AddressRole, MinCostDeliveryRole, DeliveryCityCostRole };
    emit dataChanged(topLeft, bottomRight, vectorRole);
}

Shop *ShopModel::shopById(QString id)
{
    for(int i = 0; i < shops.length(); i++) {
        if(shops.at(i)->id == id) {
            return shops.at(i);
        }
    }
    return nullptr;
}

Shop *ShopModel::shopByIndex(int index)
{
    return shops.at(index);
}

void ShopModel::clearModel()
{
    for(int i = shops.length()-1; i >= 0; i++) {
        shops.at(i)->deleteLater();
    }
    shops.clear();
}

QHash<int, QByteArray> ShopModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[AddressRole] = "address";
    roles[StatusRole] = "status";
    roles[MinCostDeliveryRole] = "minCostDeliveryRole";
    roles[DeliveryCityCostRole] = "deliveryCityCost";
    //roles[MenuRole] = "menu";
    return roles;
}
