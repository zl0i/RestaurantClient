#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>
#include <QSettings>
#include <QJsonObject>
#include <QJsonArray>

class Customer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name MEMBER name NOTIFY userChanged)
    Q_PROPERTY(QString phone MEMBER phone NOTIFY userChanged)
    Q_PROPERTY(QJsonObject address MEMBER address NOTIFY userChanged)

public:
    explicit Customer(QObject *parent = nullptr);


    void parseData(QJsonObject);

    QString getPhone();
    QString getToken();

    void save();
    void clear();

private:
    QSettings settings;

    QString name;
    QString phone;
    QJsonObject address;
    QString token;

public slots:

    bool isAuthenticated();

signals:
    void userChanged();

};

#endif // CUSTOMER_H
