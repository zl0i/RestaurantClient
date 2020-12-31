#ifndef CACHNAMFACTORY_H
#define CACHNAMFACTORY_H

#include <QObject>
#include <QQmlNetworkAccessManagerFactory>
#include <QNetworkAccessManager>
#include <QNetworkDiskCache>

class CachNAMFactory : public QQmlNetworkAccessManagerFactory
{

public:

    virtual QNetworkAccessManager *create(QObject *parent) {
        QNetworkAccessManager *nam = new QNetworkAccessManager(parent);
        QNetworkDiskCache *diskCache = new QNetworkDiskCache(parent);
        diskCache->setCacheDirectory("./cacheDir");
        nam->setCache(diskCache);
        return nam;
    }
};


#endif // CACHNAMFACTORY_H
