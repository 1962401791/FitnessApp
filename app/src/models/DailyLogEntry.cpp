#include "models/DailyLogEntry.h"

DailyLogEntry::DailyLogEntry(QObject *parent) : QObject(parent) {}

DailyLogEntry::DailyLogEntry(int id, int foodId, const QString &foodName, double amountG,
                             double proteinG, double carbsG, double fatG, double kcal,
                             const QString &loggedAt, int mealType, QObject *parent)
    : QObject(parent), m_id(id), m_foodId(foodId), m_foodName(foodName),
      m_amountG(amountG), m_proteinG(proteinG), m_carbsG(carbsG), m_fatG(fatG),
      m_kcal(kcal), m_loggedAt(loggedAt), m_mealType(qBound(0, mealType, 3)) {}

QString DailyLogEntry::mealTypeName() const
{
    switch (m_mealType) {
    case 1: return QStringLiteral("中餐");
    case 2: return QStringLiteral("晚餐");
    case 3: return QStringLiteral("加餐");
    default: return QStringLiteral("早餐");
    }
}

void DailyLogEntry::setData(int id, int foodId, const QString &foodName, double amountG,
                            double proteinG, double carbsG, double fatG, double kcal,
                            const QString &loggedAt, int mealType)
{
    m_id = id;
    m_foodId = foodId;
    m_foodName = foodName;
    m_amountG = amountG;
    m_proteinG = proteinG;
    m_carbsG = carbsG;
    m_fatG = fatG;
    m_kcal = kcal;
    m_loggedAt = loggedAt;
    m_mealType = qBound(0, mealType, 3);
}
