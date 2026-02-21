#include "models/DailyLogModel.h"

DailyLogModel::DailyLogModel(QObject *parent) : QAbstractListModel(parent) {}

int DailyLogModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_entries.size();
}

QVariant DailyLogModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_entries.size())
        return QVariant();
    DailyLogEntry *e = m_entries.at(index.row());
    switch (role) {
    case IdRole: return e->id();
    case FoodIdRole: return e->foodId();
    case FoodNameRole: return e->foodName();
    case AmountGRole: return e->amountG();
    case ProteinGRole: return e->proteinG();
    case CarbsGRole: return e->carbsG();
    case FatGRole: return e->fatG();
    case KcalRole: return e->kcal();
    case LoggedAtRole: return e->loggedAt();
    case MealTypeRole: return e->mealType();
    case MealTypeNameRole: return e->mealTypeName();
    case EntryRole: return QVariant::fromValue(e);
    default: return QVariant();
    }
}

QHash<int, QByteArray> DailyLogModel::roleNames() const
{
    return {
        { IdRole, "logId" },
        { FoodIdRole, "foodId" },
        { FoodNameRole, "foodName" },
        { AmountGRole, "amountG" },
        { ProteinGRole, "proteinG" },
        { CarbsGRole, "carbsG" },
        { FatGRole, "fatG" },
        { KcalRole, "kcal" },
        { LoggedAtRole, "loggedAt" },
        { MealTypeRole, "mealType" },
        { MealTypeNameRole, "mealTypeName" },
        { EntryRole, "entry" }
    };
}

DailyLogEntry *DailyLogModel::entryAt(int row) const
{
    if (row < 0 || row >= m_entries.size())
        return nullptr;
    return m_entries.at(row);
}

void DailyLogModel::setEntries(const QList<DailyLogEntry *> &list)
{
    beginResetModel();
    qDeleteAll(m_entries);
    m_entries = list;
    endResetModel();
    refreshTotals();
    emit countChanged();
}

void DailyLogModel::append(DailyLogEntry *entry)
{
    const int row = m_entries.size();
    beginInsertRows(QModelIndex(), row, row);
    m_entries.append(entry);
    endInsertRows();
    refreshTotals();
    emit countChanged();
    emit totalsChanged();
}

void DailyLogModel::removeAt(int row)
{
    if (row < 0 || row >= m_entries.size())
        return;
    beginRemoveRows(QModelIndex(), row, row);
    DailyLogEntry *e = m_entries.takeAt(row);
    delete e;
    endRemoveRows();
    refreshTotals();
    emit countChanged();
    emit totalsChanged();
}

void DailyLogModel::clear()
{
    beginResetModel();
    qDeleteAll(m_entries);
    m_entries.clear();
    m_totalProteinG = m_totalCarbsG = m_totalFatG = m_totalKcal = 0;
    endResetModel();
    emit countChanged();
    emit totalsChanged();
}

void DailyLogModel::refreshTotals()
{
    double p = 0, c = 0, f = 0, k = 0;
    for (DailyLogEntry *e : m_entries) {
        p += e->proteinG();
        c += e->carbsG();
        f += e->fatG();
        k += e->kcal();
    }
    if (p != m_totalProteinG || c != m_totalCarbsG || f != m_totalFatG || k != m_totalKcal) {
        m_totalProteinG = p;
        m_totalCarbsG = c;
        m_totalFatG = f;
        m_totalKcal = k;
        emit totalsChanged();
    }
}
