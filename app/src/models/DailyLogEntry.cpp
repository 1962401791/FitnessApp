#include "models/DailyLogEntry.h"

DailyLogEntry::DailyLogEntry(QObject *parent) : QObject(parent) {}

DailyLogEntry::DailyLogEntry(int id, int foodId, const QString &foodName, double amountG,
                             double proteinG, double carbsG, double fatG, double kcal,
                             const QString &loggedAt, QObject *parent)
    : QObject(parent), m_id(id), m_foodId(foodId), m_foodName(foodName),
      m_amountG(amountG), m_proteinG(proteinG), m_carbsG(carbsG), m_fatG(fatG),
      m_kcal(kcal), m_loggedAt(loggedAt) {}

void DailyLogEntry::setData(int id, int foodId, const QString &foodName, double amountG,
                            double proteinG, double carbsG, double fatG, double kcal,
                            const QString &loggedAt)
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
}
