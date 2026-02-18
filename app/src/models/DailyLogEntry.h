#ifndef DAILYLOGENTRY_H
#define DAILYLOGENTRY_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

/**
 * @brief One logged food entry for a day (food id/name snapshot + amount).
 */
class DailyLogEntry : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(int foodId READ foodId CONSTANT)
    Q_PROPERTY(QString foodName READ foodName CONSTANT)
    Q_PROPERTY(double amountG READ amountG CONSTANT)
    Q_PROPERTY(double proteinG READ proteinG CONSTANT)
    Q_PROPERTY(double carbsG READ carbsG CONSTANT)
    Q_PROPERTY(double fatG READ fatG CONSTANT)
    Q_PROPERTY(double kcal READ kcal CONSTANT)
    Q_PROPERTY(QString loggedAt READ loggedAt CONSTANT)

public:
    explicit DailyLogEntry(QObject *parent = nullptr);
    DailyLogEntry(int id, int foodId, const QString &foodName, double amountG,
                  double proteinG, double carbsG, double fatG, double kcal,
                  const QString &loggedAt, QObject *parent = nullptr);

    int id() const { return m_id; }
    int foodId() const { return m_foodId; }
    QString foodName() const { return m_foodName; }
    double amountG() const { return m_amountG; }
    double proteinG() const { return m_proteinG; }
    double carbsG() const { return m_carbsG; }
    double fatG() const { return m_fatG; }
    double kcal() const { return m_kcal; }
    QString loggedAt() const { return m_loggedAt; }

    void setData(int id, int foodId, const QString &foodName, double amountG,
                 double proteinG, double carbsG, double fatG, double kcal,
                 const QString &loggedAt);

private:
    int m_id = 0;
    int m_foodId = 0;
    QString m_foodName;
    double m_amountG = 0;
    double m_proteinG = 0;
    double m_carbsG = 0;
    double m_fatG = 0;
    double m_kcal = 0;
    QString m_loggedAt;
};

#endif // DAILYLOGENTRY_H
