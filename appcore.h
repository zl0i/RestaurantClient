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

    const QString host = "https://192.168.1.101";
    //const QString host = "https://62.109.28.233";

    QString tempPhone;

    QNetworkAccessManager manager;

signals:
    void menuSended();
    void userInfoSended();
    void error(QString);

    void authenticated();
    void payment(QString);

public slots:
    void inputByPhone(QString);
    void loginBySMS(QString);    
    void logout();

    void requestMenu();
    void makeOrder(QJsonObject info);
    void updateUserInfo();


private slots:
    void errorHandler(QNetworkReply*);
};

#endif // APPCORE_H
