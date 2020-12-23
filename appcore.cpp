#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent)
{

}

void AppCore::requestMenu()
{
    QNetworkRequest req(QUrl(host + "/azia/api/menu"));
    QNetworkReply *reply = manager.get(req);
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [&]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonObject menuObj = doc.object();
            menu.parseData(menuObj);
            emit menuSended();
        } else {
            qDebug() << "error:" << reply->errorString();
        }
    });
}

void AppCore::makeOrder()
{

}

void AppCore::requestHistory()
{

}

void AppCore::requestStatusActiveOrder()
{

}

void AppCore::addBasket(int id, int num)
{

}
