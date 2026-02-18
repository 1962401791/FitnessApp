#ifndef FOODITEM_H
#define FOODITEM_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

/**
 * @brief Single food entry in the database (per 100g or per portion).
 */
class FoodItem : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(double proteinPer100g READ proteinPer100g CONSTANT)
    Q_PROPERTY(double carbsPer100g READ carbsPer100g CONSTANT)
    Q_PROPERTY(double fatPer100g READ fatPer100g CONSTANT)
    Q_PROPERTY(double kcalPer100g READ kcalPer100g CONSTANT)
    Q_PROPERTY(QString unit READ unit CONSTANT)

public:
    explicit FoodItem(QObject *parent = nullptr);
    FoodItem(int id, const QString &name,
             double proteinPer100g, double carbsPer100g, double fatPer100g,
             double kcalPer100g, const QString &unit,
             QObject *parent = nullptr);

    int id() const { return m_id; }
    QString name() const { return m_name; }
    double proteinPer100g() const { return m_proteinPer100g; }
    double carbsPer100g() const { return m_carbsPer100g; }
    double fatPer100g() const { return m_fatPer100g; }
    double kcalPer100g() const { return m_kcalPer100g; }
    QString unit() const { return m_unit; }

    void setData(int id, const QString &name,
                 double proteinPer100g, double carbsPer100g, double fatPer100g,
                 double kcalPer100g, const QString &unit);

private:
    int m_id = 0;
    QString m_name;
    double m_proteinPer100g = 0;
    double m_carbsPer100g = 0;
    double m_fatPer100g = 0;
    double m_kcalPer100g = 0;
    QString m_unit = "g";
};

#endif // FOODITEM_H
