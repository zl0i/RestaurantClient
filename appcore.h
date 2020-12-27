#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "menumodel.h"
#include "basketmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString host MEMBER host CONSTANT)
public:
    explicit AppCore(QObject *parent = nullptr);

    MenuModel menu;
    BasketModel basket;

private:

    const QString host = "https://localhost";
    QNetworkAccessManager manager;

signals:
    void menuSended();
    void error(QString);

public slots:
    void requestMenu();
    void makeOrder();
    void requestHistory();
    void requestStatusActiveOrder();
};

#endif // APPCORE_H
