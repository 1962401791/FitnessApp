#ifndef DAILYLOGMODEL_H
#define DAILYLOGMODEL_H

#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>
#include "DailyLogEntry.h"

/**
 * @brief List model of today's diet log entries; exposes daily totals.
 */
class DailyLogModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(double totalProteinG READ totalProteinG NOTIFY totalsChanged)
    Q_PROPERTY(double totalCarbsG READ totalCarbsG NOTIFY totalsChanged)
    Q_PROPERTY(double totalFatG READ totalFatG NOTIFY totalsChanged)
    Q_PROPERTY(double totalKcal READ totalKcal NOTIFY totalsChanged)

public:
    enum Role { IdRole = Qt::UserRole + 1, FoodIdRole, FoodNameRole, AmountGRole,
                ProteinGRole, CarbsGRole, FatGRole, KcalRole, LoggedAtRole, EntryRole };

    explicit DailyLogModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    double totalProteinG() const { return m_totalProteinG; }
    double totalCarbsG() const { return m_totalCarbsG; }
    double totalFatG() const { return m_totalFatG; }
    double totalKcal() const { return m_totalKcal; }

    Q_INVOKABLE DailyLogEntry *entryAt(int row) const;
    void setEntries(const QList<DailyLogEntry *> &list);
    void append(DailyLogEntry *entry);
    void removeAt(int row);
    void clear();
    void refreshTotals();

signals:
    void countChanged();
    void totalsChanged();

private:
    QList<DailyLogEntry *> m_entries;
    double m_totalProteinG = 0;
    double m_totalCarbsG = 0;
    double m_totalFatG = 0;
    double m_totalKcal = 0;
};

#endif // DAILYLOGMODEL_H
