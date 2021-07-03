#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QTimer>

#include "customer.h"
#include "menumodel.h"
#include "basketmodel.h"
#include "activeorder.h"
#include "shopmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString host MEMBER host CONSTANT)
    Q_PROPERTY(Shop *currentShop MEMBER currentShop NOTIFY currentShopChanged)

public:
    explicit AppCore(QObject *parent = nullptr);

    Customer user;    
    BasketModel basket;
    ActiveOrder activeOrder;
    ShopModel shopsModel;

private:   

    const QString host = "https://192.168.1.102/restaurant";
    //const QString host = "https://zloi.space/restaurant";

    QString tempPhone;
    QTimer timer;

    QNetworkAccessManager manager;

    Shop *currentShop = nullptr;

signals:
    void shopsSended();
    void userInfoSended();
    void makeOrderError();
    void error(QString);

    void authenticated();
    void payment(QString html);

    void shopModelChanged();
    void currentShopChanged();

public slots:
    void inputByPhone(QString);
    void loginBySMS(QString);    
    void logout();

    void requestShops();
    void selectShop(QString id);
    void makeOrder(QJsonObject info);
    void cancelOrder();
    void updateUserInfo();
    void openPaymentForm();


private slots:
    void errorHandler(QNetworkReply*);
};

#endif // APPCORE_H
