#include "menumodel.h"

MenuModel::MenuModel(QObject *parent) : QStandardItemModel(parent)
{
    //fillFromSetting();
}

void MenuModel::parseData(QJsonObject obj)
{
    categories.clear();
    QJsonArray cat = obj.value("category").toArray();
    for(int i = 0; i < cat.size(); i++) {
        categories.append(cat.at(i).toString());
    }
    emit categoriesChanged();    

    clearModel();
    QJsonArray menu = obj.value("menu").toArray();
    insertColumn(0);
    insertRows(0, menu.size());
    for(int i = 0; i < menu.size(); i++) {
        QJsonObject itemJson = menu.at(i).toObject();
        QModelIndex index = this->index(i, 0);
        setData(index, itemJson.value("id"), IdRole);
        setData(index, itemJson.value("name").toString(), NameRole);
        setData(index, categories.at(itemJson.value("category_index").toInt()), CategoryRole);
        setData(index, itemJson.value("image"), ImageRole);
        setData(index, itemJson.value("description"), DescriptionRole);
        setData(index, itemJson.value("cost"), CostRole);
    }
    //save();
}

void MenuModel::fillFromSetting()
{
    clearModel();
    QJsonArray arr = settings.value("menu").toJsonArray();
    insertColumn(0);
    insertRows(0, arr.size());
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject itemJson = arr.at(i).toObject();
        QModelIndex index = this->index(i, 0);
        setData(index, itemJson.value("id").toString(), IdRole);
        setData(index, itemJson.value("name").toString(), NameRole);
        setData(index, itemJson.value("category"), CategoryRole);
        setData(index, itemJson.value("image"), ImageRole);
        setData(index, itemJson.value("description"), DescriptionRole);
        setData(index, itemJson.value("cost"), CostRole);
    }

    categories.clear();
    QJsonArray cat = settings.value("categories").toJsonArray();
    for(int i = 0; i < cat.size(); i++) {
        categories.append(cat.at(i).toString());
    }
    emit categoriesChanged();
}

void MenuModel::save()
{
    QJsonArray arr;
    for(int i = 0; i < rowCount(); i++) {
        QJsonObject obj;
        QModelIndex idx = this->index(i, 0);
        obj.insert("id", data(idx, IdRole).toJsonValue());
        obj.insert("name", data(idx, NameRole).toJsonValue());
        obj.insert("category", data(idx, CategoryRole).toJsonValue());
        obj.insert("image", data(idx, ImageRole).toJsonValue());
        obj.insert("description", data(idx, DescriptionRole).toJsonValue());
        obj.insert("cost", data(idx, CostRole).toJsonValue());
        arr.append(obj);
    }
    settings.setValue("menu", arr);

    QJsonArray cat;
    for(int i = 0; i < categories.size(); i++) {
        cat.append(categories.at(i));
    }
    settings.setValue("categories", cat);
}

void MenuModel::clearModel()
{
    removeColumn(0);
    removeRows(0, rowCount());
}

void MenuModel::clearSetting()
{
    settings.remove("menu");
    settings.remove("categories");
}

void MenuModel::setCountItem(int row, int num)
{    
    QModelIndex index = this->index(row, 0);
    setData(index, num, MenuModel::CountRole);
    emit countChanged();
}

void MenuModel::setCountItem(QString id, int num)
{   
    QModelIndex index = indexById(id);
    setData(index, num, MenuModel::CountRole);
    emit countChanged();
}

int MenuModel::findIndexByCategory(QString cat)
{
    for(int i = 0; i < rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        if(data(index, MenuRoles::CategoryRole).toString() == cat) {
            return index.row();
        }
    }
    return 0;
}

QModelIndex MenuModel::indexById(QString id)
{
    for(int i = 0; i < rowCount(); i++) {
        QModelIndex index = this->index(i, 0);
        if(data(index, MenuRoles::IdRole).toString() == id) {
            return index;
        }
    }
    return QModelIndex();
}

QHash<int, QByteArray> MenuModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CategoryRole] = "category";
    roles[CostRole] = "cost";
    roles[DescriptionRole] = "description";
    roles[ImageRole] = "image";
    roles[CountRole] = "count";
    return roles;
}
