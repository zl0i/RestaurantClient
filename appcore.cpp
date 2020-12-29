#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent), basket(&menu)
{

}

void AppCore::inputByPhone(QString phone)
{
    qDebug() << "inputByPhone:" << phone;
    tempPhone = phone;
}

void AppCore::loginBySMS(QString code)
{
    qDebug() << "loginBySMS:" << tempPhone << "code:" << code;
    user.parseData(QJsonObject {});
    if(tempPhone == "+79999999999" && code == "9674") {
        emit authenticated();
    } else {
        emit error("code not valid");
    }
}

void AppCore::loginByToken()
{
    qDebug() << "loginByToken";
    user.parseData(QJsonObject {});
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
            emit menuSended();
            emit error(reply->errorString());
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
