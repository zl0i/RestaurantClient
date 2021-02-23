#ifndef SHOPMODEL_H
#define SHOPMODEL_H

#include <QObject>
#include <QModelIndex>
#include <QStandardItemModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QSettings>
#include <QModelIndex>


#include "shop.h"

class ShopModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ShopModel(QObject *parent = nullptr);

    typedef enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        AddressRole,
        StatusRole,
        MinCostDeliveryRole,
        DeliveryCityCostRole,
        MenuRole
    }ShopRoles;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void parseData(QJsonArray arr);
    Shop *shopById(QString id);
    Shop *shopByIndex(int index);
    void clearModel();

private:

    QList<Shop*> shops;
    QHash<int, QByteArray> roleNames() const override;

signals:

};

#endif // SHOPMODEL_H
