#ifndef ACTIVEORDER_H
#define ACTIVEORDER_H

#include <QObject>
#include <QDateTime>

class ActiveOrder : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString datetime MEMBER datetime NOTIFY activeOrderChanged)
    Q_PROPERTY(QString status MEMBER status NOTIFY activeOrderChanged)
    Q_PROPERTY(qreal total MEMBER total NOTIFY activeOrderChanged)

public:
    QString datetime;
    qreal total = 0;
    QString status;
    QString payment_token;

signals:
    void activeOrderChanged();
};

#endif // ACTIVEORDER_H
