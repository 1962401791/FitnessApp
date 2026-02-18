#ifndef FOODLISTMODEL_H
#define FOODLISTMODEL_H

#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>
#include "FoodItem.h"

/**
 * @brief List model of FoodItem for selection/search in Add Food flow.
 */
class FoodListModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    enum Role { IdRole = Qt::UserRole + 1, NameRole, ProteinPer100gRole,
                CarbsPer100gRole, FatPer100gRole, KcalPer100gRole, UnitRole, ItemRole };

    explicit FoodListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE FoodItem *itemAt(int row) const;
    Q_INVOKABLE void setFoods(const QList<FoodItem *> &list);
    void append(FoodItem *item);
    void clear();

signals:
    void countChanged();

private:
    QList<FoodItem *> m_items;
};

#endif // FOODLISTMODEL_H
