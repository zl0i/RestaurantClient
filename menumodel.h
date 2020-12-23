#ifndef MENUITEMS_H
#define MENUITEMS_H

#include <QObject>
#include <QModelIndex>
#include <QStandardItemModel>
#include <QSortFilterProxyModel>
#include <QUrl>
#include <QJsonArray>
#include <QJsonObject>

class MenuModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QStringList categories MEMBER categories NOTIFY categoriesChanged)

public:

    typedef struct {
        QString id;
        QString name;
        QString category;
        double cost;
        QString description;
        QUrl imageUrl;
    }MenuItem;

    explicit MenuModel(QObject *parent = nullptr);

    void parseData(QJsonObject obj);

    QHash<int, QByteArray> roleNames() const;

private:

    typedef enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        CategoryRole,
        CostRole,
        DescriptionRole,
        ImageRole
    }MenuRoles;

     QStandardItemModel menus;
     QStringList categories;

signals:

     void categoriesChanged();
};

#endif // MENUITEMS_H
