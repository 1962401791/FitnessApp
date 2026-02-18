#ifndef STORAGESERVICE_H
#define STORAGESERVICE_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QSqlDatabase>
#include "../models/FoodItem.h"
#include "../models/DailyLogEntry.h"
#include "../models/FoodListModel.h"
#include "../models/DailyLogModel.h"

/**
 * @brief SQLite storage for food database and daily intake log.
 * Creates schema, seeds default foods, and provides CRUD for log entries.
 */
class StorageService : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(FoodListModel *foodListModel READ foodListModel CONSTANT)
    Q_PROPERTY(DailyLogModel *dailyLogModel READ dailyLogModel CONSTANT)
    Q_PROPERTY(double goalProteinG READ goalProteinG WRITE setGoalProteinG NOTIFY goalProteinGChanged)
    Q_PROPERTY(double goalCarbsG READ goalCarbsG WRITE setGoalCarbsG NOTIFY goalCarbsGChanged)
    Q_PROPERTY(double goalFatG READ goalFatG WRITE setGoalFatG NOTIFY goalFatGChanged)
    Q_PROPERTY(int userAge READ userAge WRITE setUserAge NOTIFY userAgeChanged)
    Q_PROPERTY(double userHeightCm READ userHeightCm WRITE setUserHeightCm NOTIFY userHeightCmChanged)
    Q_PROPERTY(double userWeightKg READ userWeightKg WRITE setUserWeightKg NOTIFY userWeightKgChanged)
    Q_PROPERTY(bool userIsMale READ userIsMale WRITE setUserIsMale NOTIFY userIsMaleChanged)
    Q_PROPERTY(int userGoal READ userGoal WRITE setUserGoal NOTIFY userGoalChanged)
    Q_PROPERTY(int userActivityLevel READ userActivityLevel WRITE setUserActivityLevel NOTIFY userActivityLevelChanged)
    Q_PROPERTY(bool hasBasicInfo READ hasBasicInfo NOTIFY hasBasicInfoChanged)
    Q_PROPERTY(bool hasSeenOnboarding READ hasSeenOnboarding WRITE setHasSeenOnboarding NOTIFY hasSeenOnboardingChanged)

public:
    explicit StorageService(QObject *parent = nullptr);
    ~StorageService() override;

    bool init();
    bool isOpen() const { return m_db.isOpen(); }

    FoodListModel *foodListModel() { return &m_foodListModel; }
    DailyLogModel *dailyLogModel() { return &m_dailyLogModel; }

    double goalProteinG() const { return m_goalProteinG; }
    void setGoalProteinG(double v);
    double goalCarbsG() const { return m_goalCarbsG; }
    void setGoalCarbsG(double v);
    double goalFatG() const { return m_goalFatG; }
    void setGoalFatG(double v);

    int userAge() const { return m_userAge; }
    void setUserAge(int v);
    double userHeightCm() const { return m_userHeightCm; }
    void setUserHeightCm(double v);
    double userWeightKg() const { return m_userWeightKg; }
    void setUserWeightKg(double v);
    bool userIsMale() const { return m_userIsMale; }
    void setUserIsMale(bool v);
    int userGoal() const { return m_userGoal; }
    void setUserGoal(int v);
    int userActivityLevel() const { return m_userActivityLevel; }
    void setUserActivityLevel(int v);
    bool hasBasicInfo() const { return m_userAge > 0 && m_userHeightCm > 0; }
    bool hasSeenOnboarding() const { return m_hasSeenOnboarding; }
    void setHasSeenOnboarding(bool v);

    /** Load all foods into foodListModel. */
    Q_INVOKABLE void loadFoods();
    /** Filter foods by name (substring). */
    Q_INVOKABLE void searchFoods(const QString &query);
    /** Load today's log into dailyLogModel. */
    Q_INVOKABLE void loadTodayLog();
    /**
     * Add a log entry for today for the given food and amount (g).
     * Computes macros and stores; refreshes dailyLogModel.
     */
    Q_INVOKABLE bool addLogEntry(int foodId, double amountG);
    /** Remove log entry by row index in current daily list. */
    Q_INVOKABLE bool removeLogEntryAt(int row);

signals:
    void errorOccurred(const QString &error);
    void goalProteinGChanged();
    void goalCarbsGChanged();
    void goalFatGChanged();
    void userAgeChanged();
    void userHeightCmChanged();
    void userWeightKgChanged();
    void userIsMaleChanged();
    void userGoalChanged();
    void userActivityLevelChanged();
    void hasBasicInfoChanged();
    void hasSeenOnboardingChanged();

private:
    bool createSchema();
    bool seedDefaultFoods();
    void loadGoals();
    void loadBasicInfo();

    QSqlDatabase m_db;
    FoodListModel m_foodListModel;
    DailyLogModel m_dailyLogModel;
    double m_goalProteinG = 120;
    double m_goalCarbsG = 250;
    double m_goalFatG = 65;
    int m_userAge = 0;
    double m_userHeightCm = 0;
    double m_userWeightKg = 65;
    bool m_userIsMale = true;
    int m_userGoal = 0;           /* 0=lose weight, 1=gain, 2=muscle, 3=improve body, 4=other */
    int m_userActivityLevel = 0;   /* 0=beginner, 1=intermediate, 2=advanced */
    bool m_hasSeenOnboarding = false;
};

#endif // STORAGESERVICE_H
