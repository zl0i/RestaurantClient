#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "customer.h"
#include "menumodel.h"
#include "basketmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString host MEMBER host CONSTANT)
public:
    explicit AppCore(QObject *parent = nullptr);

    Customer user;
    MenuModel menu;
    BasketModel basket;

private:

    const QString host = "https://localhost";
    QString tempPhone;

    QNetworkAccessManager manager;

signals:
    void menuSended();
    void error(QString);

    void authenticated();
    void payment(QString);

public slots:
    void inputByPhone(QString);
    void loginBySMS(QString);
    void loginByToken();
    void logout();

    void requestMenu();
    void makeOrder(QJsonObject info);
    void requestHistory();
    void requestStatusActiveOrder();
};

#endif // APPCORE_H
