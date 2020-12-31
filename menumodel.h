#ifndef MENUITEMS_H
#define MENUITEMS_H

#include <QObject>
#include <QModelIndex>
#include <QStandardItemModel>
#include <QSortFilterProxyModel>
#include <QUrl>
#include <QJsonArray>
#include <QJsonObject>
#include <QSettings>

class MenuModel : public QStandardItemModel
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

    typedef enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        CategoryRole,
        CostRole,
        DescriptionRole,
        ImageRole,
        CountRole
    }MenuRoles;

    explicit MenuModel(QObject *parent = nullptr);

    void parseData(QJsonObject obj);

    void fillFromSetting();
    void save();
    void clearSetting();
    void clearModel();

private:

    QSettings settings;
    QStringList categories;

    QModelIndex indexById(QString id);

    QHash<int, QByteArray> roleNames() const;

public slots:

    void setCountItem(int row, int num);
    void setCountItem(QString id, int num);

    int findIndexByCategory(QString cat);

signals:

    void countChanged();

    void categoriesChanged();
};

#endif // MENUITEMS_H
