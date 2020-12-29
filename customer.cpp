#include "customer.h"

Customer::Customer(QObject *parent) : QObject(parent)
{

    phone = settings.value("phone", "").toString();
    name = settings.value("name", "").toString();
    address = settings.value("address", QJsonArray {
                                 QJsonObject{
                                     {"street", ""},
                                     {"house", ""},
                                     {"flat", ""}
                                 }
                             }).toJsonArray();
}

void Customer::parseData(QJsonObject)
{


}
