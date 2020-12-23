#ifndef BASKETMODEL_H
#define BASKETMODEL_H

#include <QObject>

class BasketModel : public QObject
{
    Q_OBJECT
public:
    explicit BasketModel(QObject *parent = nullptr);

signals:

};

#endif // BASKETMODEL_H
