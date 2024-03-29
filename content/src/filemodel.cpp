#include "filemodel.h"
#include <QFile>
#include <QFileInfo>

FileModel::FileModel(QObject *parent)
    : QAbstractListModel(parent)
{
    this->files = QList<FileItem>();
}

void FileModel::addItem(const FileItem &item)
{
    beginInsertRows(QModelIndex(), files.size(), files.size());
    files.append(item);
    endInsertRows();
}

void FileModel::removeItem(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    files.removeAt(index);
    endRemoveRows();
}

void FileModel::clearItems()
{
    beginRemoveRows(QModelIndex(), 0, files.size() - 1);
    files.clear();
    endRemoveRows();
}

QVariantMap FileModel::get(int index) const
{
    if (index < 0 || index >= files.size())
        return QVariantMap();
    const FileItem &item = files.at(index);
    QVariantMap map;
    map["name"] = item.name;
    map["extension"] = item.extension;
    map["path"] = item.path;
    map["icon"] = item.icon;
    return map;
}

QList<FileItem> FileModel::getItems() const
{
    return this->files;
}

int FileModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return files.size();
}

QVariant FileModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= files.size())
        return QVariant();

    const FileItem &item = files.at(index.row());
    switch (role)
    {
    case NameRole:
        return item.name;
    case ExtensionRole:
        return item.extension;
    case PathRole:
        return item.path;
    case IconRole:
        return item.icon;
    default:
        return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> FileModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ExtensionRole] = "extension";
    roles[PathRole] = "path";
    roles[IconRole] = "icon";
    return roles;
}