#include "models/FoodItem.h"

FoodItem::FoodItem(QObject *parent) : QObject(parent) {}

FoodItem::FoodItem(int id, const QString &name,
                   double proteinPer100g, double carbsPer100g, double fatPer100g,
                   double kcalPer100g, const QString &unit,
                   QObject *parent)
    : QObject(parent), m_id(id), m_name(name),
      m_proteinPer100g(proteinPer100g), m_carbsPer100g(carbsPer100g),
      m_fatPer100g(fatPer100g), m_kcalPer100g(kcalPer100g), m_unit(unit) {}

void FoodItem::setData(int id, const QString &name,
                       double proteinPer100g, double carbsPer100g, double fatPer100g,
                       double kcalPer100g, const QString &unit)
{
    m_id = id;
    m_name = name;
    m_proteinPer100g = proteinPer100g;
    m_carbsPer100g = carbsPer100g;
    m_fatPer100g = fatPer100g;
    m_kcalPer100g = kcalPer100g;
    m_unit = unit;
}
