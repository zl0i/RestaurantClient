#ifndef MENUITEMS_H
#define MENUITEMS_H

#include <QObject>
#include <QAbstractListModel>
#include <QUrl>
#include <QJsonArray>
#include <QJsonObject>

class MenuItems : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MenuItems(QObject *parent = nullptr);

    void parseData(QJsonArray arr);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    typedef struct {
        QString id;
        QString name;
        QString category;
        double cost;
        QString description;
        QUrl imageUrl;
    }MenuItem;

    typedef enum {
        IdRole,
        NameRole,
        CategoryRole,
        CostRole,
        DescriptionRole,
        ImageRole
    }MenuRoles;

     QList<MenuItem> menus;

signals:

};

#endif // MENUITEMS_H
