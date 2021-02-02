#ifndef ORDERHISTORYMODEL_H
#define ORDERHISTORYMODEL_H

#include <QObject>
#include <QModelIndex>
#include <QStandardItemModel>
#include <QJsonArray>
#include <QJsonObject>

class OrderHistoryModel : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit OrderHistoryModel(QObject *parent = nullptr);

    void parseData(QJsonArray arr);

    void clearModel();

    typedef enum {
        IdRole = Qt::UserRole+1,
        DatetimeRole,
        CostRole
    } OrderRoles;

private:

    QHash<int, QByteArray> roleNames() const;


signals:

};

#endif // ORDERHISTORYMODEL_H
