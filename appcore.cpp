#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent), basket(&menu)
{
    loginByToken();
}

void AppCore::inputByPhone(QString phone)
{
    qDebug() << "inputByPhone:" << phone;
    tempPhone = phone;

    QNetworkRequest req(QUrl(host + "/azia/api/users/input"));
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QJsonObject obj {
        {"phone", tempPhone}
    };
    QNetworkReply *reply = manager.post(req, QJsonDocument(obj).toJson());
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {

        } else {
            qDebug() << "error:" << reply->errorString();
            emit error(reply->errorString());
        }
    });
}

void AppCore::loginBySMS(QString code)
{
    qDebug() << "loginBySMS:" << tempPhone << "code:" << code;

    QNetworkRequest req(QUrl(host + "/azia/api/users/login"));
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QJsonObject obj {
        {"phone", tempPhone},
        {"code", code}
    };
    QNetworkReply *reply = manager.post(req, QJsonDocument(obj).toJson());
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit authenticated();
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            user.parseData(doc.object());
        } else {
            qDebug() << "error:" << reply->errorString();
            emit error(reply->errorString());
        }
    });
}

void AppCore::loginByToken()
{

    if(user.getToken().isEmpty())
        return;

    qDebug() << "loginByToken";
    QNetworkRequest req(QUrl(host + "/azia/api/users/token"));
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QJsonObject obj {
        {"phone", user.getPhone()},
        {"token", user.getToken()}
    };
    QNetworkReply *reply = manager.post(req, QJsonDocument(obj).toJson());
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit authenticated();
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            user.parseData(doc.object());
        } else {
            qDebug() << "error:" << reply->errorString();
            emit error(reply->errorString());
        }
    });
}

void AppCore::logout()
{
    user.clear();
}

void AppCore::requestMenu()
{
    qDebug() << "requestMenu";

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
    QNetworkRequest req(QUrl(host + "/azia/api/orders"));

    QJsonObject obj;
    obj.insert("menu", basket.order());
    obj.insert("phone", user.getPhone());
    obj.insert("token", user.getToken());

    QJsonDocument doc(obj);
    QNetworkReply *reply = manager.post(req, doc.toJson());
    QObject::connect(reply, &QNetworkReply::finished, [&]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
        } else {
            qDebug() << "error:" << reply->errorString();
            emit error(reply->errorString());
        }
    });
}

void AppCore::requestHistory()
{

}

void AppCore::requestStatusActiveOrder()
{

}
