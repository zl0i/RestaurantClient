#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent)
{
    requestShops();
    timer.setInterval(1000*60*5);
    connect(&timer, &QTimer::timeout, this, &AppCore::updateUserInfo);
    if(user.isAuthenticated()) {
        updateUserInfo();
        timer.start();
    }
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
            timer.start();
        } else {
            qDebug() << "error:" << reply->errorString();
            emit error(reply->errorString());
        }
    });
}

void AppCore::logout()
{
    user.clear();
    timer.stop();
}

void AppCore::requestShops()
{
    qDebug() << "requestShops";

    QUrl url(host + "/azia/api/shops");

    QNetworkRequest req(url);
    QNetworkReply *reply = manager.get(req);
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonArray shopsArr = doc.array();
            shopsModel.parseData(shopsArr);
            if(!currentShop) {
                currentShop = shopsModel.shopByIndex(0);
                basket.setSourceModel(currentShop->menu);
                activeOrder.setMenu(currentShop->menu);
                emit currentShopChanged();
            }
        } else {
            qDebug() << "error:" << reply->errorString();
            errorHandler(reply);
        }
        emit shopsSended();
        reply->deleteLater();
    });
}

void AppCore::selectShop(QString id)
{
    Shop *shop = shopsModel.shopById(id);
    if(shop) {
        basket.setSourceModel(shop->menu);
        activeOrder.setMenu(shop->menu);
        currentShop = shop;
        emit currentShopChanged();
    }
}

void AppCore::makeOrder(QJsonObject info)
{
    if(!user.isAuthenticated()) {
        emit error(tr("Сначала авторизуйтесь"));
        return;
    }

    QNetworkRequest req(QUrl(host + "/azia/api/orders"));
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject obj;
    obj.insert("shop_id", currentShop->id);
    obj.insert("token", user.getToken());
    obj.insert("menu", basket.order());
    obj.insert("phoneUser", user.getPhone());
    obj.insert("phoneOrder", info.value("phone"));
    obj.insert("comment", info.value("comment"));
    obj.insert("address", info.value("address"));
    QJsonDocument doc(obj);

    user.setAddress(info.value("address").toObject());

    QNetworkReply *reply = manager.post(req, doc.toJson());
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonObject obj = doc.object();
            QString token = obj.value("payment_token").toString();

            user.setPaymentToken(token);
            openPaymentForm();
            basket.clearBasket();
        } else {
            emit makeOrderError();
            qDebug() << "error:" << reply->errorString();
            errorHandler(reply);
        }
        reply->deleteLater();
    });
}

void AppCore::cancelOrder()
{
    if(activeOrder.getId().isEmpty())
        return;

    QUrl url(host + "/azia/api/orders/" + activeOrder.getId());

    QNetworkRequest req(url);
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = manager.deleteResource(req);
    reply->ignoreSslErrors();
    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            QJsonObject obj = doc.object();
            activeOrder.clearOrder();
        } else {
            qDebug() << "error:" << reply->errorString();
            errorHandler(reply);
        }
        reply->deleteLater();
    });
}

void AppCore::updateUserInfo()
{
    if(!user.isAuthenticated()) {
        emit error(tr("Сначала авторизуйтесь"));
        return;
    }

    QUrl url(host + "/azia/api/users/info");
    QJsonObject obj;
    obj.insert("phone", user.getPhone());
    obj.insert("token", user.getToken());
    QJsonDocument doc(obj);

    QNetworkRequest req(url);
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply *reply = manager.post(req, doc.toJson());
    reply->ignoreSslErrors();

    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QByteArray arr = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(arr);
            activeOrder.parseData(doc.object().value("activeOrder").toObject());
            user.parseData(doc.object());
        } else {
            qDebug() << "error:" << reply->errorString();
            errorHandler(reply);
        }
        emit userInfoSended();
        reply->deleteLater();
    });
}

void AppCore::openPaymentForm()
{
    QFile file(":icons/payment-page.html");
    file.open(QIODevice::ReadOnly);

    QString html = file.readAll();

    html.replace("%1", user.getPaymentToken());
    html.replace("%2", host + "/azia/html/paymentSuccess.html");
    emit payment(html);
}

void AppCore::errorHandler(QNetworkReply *reply)
{
    const QNetworkReply::NetworkError err = reply->error();

    switch (err) {
    case QNetworkReply::HostNotFoundError:
        emit error(tr("Сервер не найден"));
        break;
    case QNetworkReply::InternalServerError:
        emit error(tr("Внутрення ошибка сервера"));
        break;
    case QNetworkReply::ProtocolInvalidOperationError: {
        QByteArray arr = reply->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(arr);
        QJsonObject errorObj = doc.object();
        QString errorString = errorObj.value("result").toString();
        emit error(errorString);
        break;
    }
    case QNetworkReply::UnknownNetworkError:
        emit error("Неизвестная ошибка");
        break;
    default:
        emit error(tr("Внутрення ошибка"));
    }
}
