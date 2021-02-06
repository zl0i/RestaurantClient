#include "customer.h"

Customer::Customer(QObject *parent) : QObject(parent)
{

    phone = settings.value("phone", "").toString();
    token = settings.value("token").toString();
    name = settings.value("name", "").toString();
    paymentToken = settings.value("payment_token", "").toString();
    address = settings.value("address", QJsonObject {
                                 {"street", ""},
                                 {"house", ""},
                                 {"flat", ""}
                             }).toJsonObject();

    qDebug() << "user info:" << '\n'
             << "phone:" << phone << '\n'
             << "token:" << token << '\n'
             << "address:" << address << '\n';
}

bool Customer::isAuthenticated()
{
    return !token.isEmpty();
}

void Customer::parseData(QJsonObject obj)
{
    phone = obj.value("phone").toString();
    token = obj.value("token").toString();
    address = obj.value("address").toObject();    
    orders->parseData(obj.value("history").toArray());    
    emit userChanged();
    save();
}

QString Customer::getPhone()
{
    return phone;
}

QString Customer::getToken()
{
    return token;
}

void Customer::setAddress(QJsonObject obj)
{
    address = obj;
    settings.setValue("address", address);
}

void Customer::save()
{
    settings.setValue("phone", phone);
    settings.setValue("token", token);
    settings.setValue("address", address);
    settings.setValue("payment_token", paymentToken);
}

void Customer::clear()
{
    phone = "";
    token = "";
    name = "";
    paymentToken = "";
    orders->clearModel();
    address = QJsonObject();
    save();
    emit userChanged();
}

void Customer::setPaymentToken(QString ptoken)
{
    paymentToken = ptoken;
}

QString Customer::getPaymentToken()
{
    return paymentToken;
}
