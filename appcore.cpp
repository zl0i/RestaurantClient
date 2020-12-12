#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent)
{


    /*QNetworkAccessManager manager;
    QNetworkRequest req(QUrl("https://78.24.216.174/aziaclient/menu"));
    QNetworkReply *reply = manager.get(req);
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [&]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonArray menu = doc.array();
            qDebug() << menu.size();
            qDebug() << menu.at(0);

        } else {
            qDebug() << "error:" << reply->errorString();
        }
    });*/
}
