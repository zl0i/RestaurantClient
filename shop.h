#ifndef SHOP_H
#define SHOP_H

#include <QObject>

#include <QJsonObject>

#include "menumodel.h"

class Shop : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name MEMBER name NOTIFY shopChanged)
    Q_PROPERTY(QString address MEMBER address NOTIFY shopChanged)
    Q_PROPERTY(QString status MEMBER status NOTIFY shopChanged)
    Q_PROPERTY(int minCostDelivery MEMBER minCostDelivery NOTIFY shopChanged)
    Q_PROPERTY(QJsonObject deliveryCityCost MEMBER deliveryCityCost NOTIFY shopChanged)
    Q_PROPERTY(MenuModel *menu MEMBER menu NOTIFY shopChanged)
public:
    explicit Shop(QObject *parent = nullptr);

    QString id;
    QString name;
    QString address;
    QString status;
    int minCostDelivery;
    QJsonObject deliveryCityCost;
    MenuModel *menu;

signals:
    void shopChanged();

};

#endif // SHOP_H
