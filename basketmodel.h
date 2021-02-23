#ifndef BASKETMODEL_H
#define BASKETMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>
#include <QJsonArray>
#include <QJsonObject>

#include "menumodel.h"

class BasketModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(int total READ getTotal NOTIFY totalChanged)
public:
    explicit BasketModel(QObject *parent = nullptr);

    QJsonArray order();
    void clearBasket();

private:
    MenuModel *menus;
    int total = 0;

    int getTotal() { return total; }

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private slots:
    void calcTotal();

signals:
    void totalChanged();

};

#endif // BASKETMODEL_H
