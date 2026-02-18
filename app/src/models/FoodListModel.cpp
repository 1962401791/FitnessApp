#include "models/FoodListModel.h"

FoodListModel::FoodListModel(QObject *parent) : QAbstractListModel(parent) {}

int FoodListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_items.size();
}

QVariant FoodListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_items.size())
        return QVariant();
    FoodItem *item = m_items.at(index.row());
    switch (role) {
    case IdRole: return item->id();
    case NameRole: return item->name();
    case ProteinPer100gRole: return item->proteinPer100g();
    case CarbsPer100gRole: return item->carbsPer100g();
    case FatPer100gRole: return item->fatPer100g();
    case KcalPer100gRole: return item->kcalPer100g();
    case UnitRole: return item->unit();
    case ItemRole: return QVariant::fromValue(item);
    default: return QVariant();
    }
}

QHash<int, QByteArray> FoodListModel::roleNames() const
{
    return {
        { IdRole, "foodId" },
        { NameRole, "name" },
        { ProteinPer100gRole, "proteinPer100g" },
        { CarbsPer100gRole, "carbsPer100g" },
        { FatPer100gRole, "fatPer100g" },
        { KcalPer100gRole, "kcalPer100g" },
        { UnitRole, "unit" },
        { ItemRole, "item" }
    };
}

FoodItem *FoodListModel::itemAt(int row) const
{
    if (row < 0 || row >= m_items.size())
        return nullptr;
    return m_items.at(row);
}

void FoodListModel::setFoods(const QList<FoodItem *> &list)
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    for (FoodItem *item : list)
        m_items.append(item);
    endResetModel();
    emit countChanged();
}

void FoodListModel::append(FoodItem *item)
{
    const int row = m_items.size();
    beginInsertRows(QModelIndex(), row, row);
    m_items.append(item);
    endInsertRows();
    emit countChanged();
}

void FoodListModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
    emit countChanged();
}
