#include "services/StorageService.h"
#include "core/NutritionCalculator.h"
#include <QStandardPaths>
#include <QDir>
#include <QSqlQuery>
#include <QSqlError>
#include <QDate>
#include <QDateTime>

StorageService::StorageService(QObject *parent) : QObject(parent) {}

StorageService::~StorageService()
{
    if (m_db.isOpen())
        m_db.close();
}

bool StorageService::init()
{
    const QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    const QString dbPath = path + "/fitness.db";
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(dbPath);
    if (!m_db.open()) {
        emit errorOccurred(m_db.lastError().text());
        return false;
    }
    if (!createSchema()) {
        emit errorOccurred("Failed to create schema");
        return false;
    }
    loadGoals();
    loadBasicInfo();
    loadFoods();
    loadTodayLog();
    return true;
}

void StorageService::loadBasicInfo()
{
    QSqlQuery q(m_db);
    if (q.exec("SELECT key, value FROM settings WHERE key IN ('userAge','userHeightCm','userWeightKg','userIsMale','userGoal','userActivityLevel','hasSeenOnboarding')")) {
        while (q.next()) {
            QString k = q.value(0).toString();
            QString v = q.value(1).toString();
            if (k == "userAge") m_userAge = v.toInt();
            else if (k == "userHeightCm") m_userHeightCm = v.toDouble();
            else if (k == "userWeightKg") m_userWeightKg = v.toDouble();
            else if (k == "userIsMale") m_userIsMale = (v == "1");
            else if (k == "userGoal") m_userGoal = qBound(0, v.toInt(), 4);
            else if (k == "userActivityLevel") m_userActivityLevel = qBound(0, v.toInt(), 2);
            else if (k == "hasSeenOnboarding") m_hasSeenOnboarding = (v == "1");
        }
    }
}

bool StorageService::createSchema()
{
    QSqlQuery q(m_db);
    if (!q.exec("CREATE TABLE IF NOT EXISTS foods ("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name TEXT NOT NULL, "
                "protein_per100g REAL NOT NULL DEFAULT 0, "
                "carbs_per100g REAL NOT NULL DEFAULT 0, "
                "fat_per100g REAL NOT NULL DEFAULT 0, "
                "kcal_per100g REAL NOT NULL DEFAULT 0, "
                "unit TEXT DEFAULT 'g')"))
        return false;
    if (!q.exec("CREATE TABLE IF NOT EXISTS daily_log ("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "log_date DATE NOT NULL, "
                "food_id INTEGER NOT NULL, "
                "food_name TEXT NOT NULL, "
                "amount_g REAL NOT NULL, "
                "protein_g REAL NOT NULL, carbs_g REAL NOT NULL, fat_g REAL NOT NULL, kcal REAL NOT NULL, "
                "logged_at TEXT, "
                "FOREIGN KEY (food_id) REFERENCES foods(id))"))
        return false;
    if (!q.exec("CREATE TABLE IF NOT EXISTS settings ("
                "key TEXT PRIMARY KEY, value TEXT)"))
        return false;
    if (!q.exec("CREATE INDEX IF NOT EXISTS idx_daily_log_date ON daily_log(log_date)"))
        return false;

    // Migration: add meal_type if missing (0=breakfast, 1=lunch, 2=dinner, 3=snack)
    QSqlQuery checkCol(m_db);
    if (checkCol.exec("SELECT COUNT(*) FROM pragma_table_info('daily_log') WHERE name='meal_type'")
        && checkCol.next() && checkCol.value(0).toInt() == 0) {
        if (!q.exec("ALTER TABLE daily_log ADD COLUMN meal_type INTEGER NOT NULL DEFAULT 0"))
            return false;
    }

    QSqlQuery check(m_db);
    if (check.exec("SELECT COUNT(*) FROM foods") && check.next() && check.value(0).toInt() == 0)
        return seedDefaultFoods();
    return true;
}

bool StorageService::seedDefaultFoods()
{
    struct Seed { const char *name; double p, c, f, kcal; };
    const Seed seeds[] = {
        {"Chicken breast", 31, 0, 3.6, 165},
        {"Rice cooked", 2.7, 28, 0.3, 130},
        {"Egg whole", 12.6, 0.6, 9.5, 155},
        {"Broccoli", 2.8, 7, 0.4, 34},
        {"Olive oil", 0, 0, 100, 884},
        {"Banana", 1.1, 23, 0.3, 89},
        {"Oatmeal", 2.4, 12, 1.4, 68},
        {"Salmon", 20, 0, 13, 208},
        {"Greek yogurt", 10, 3.6, 0.7, 59},
        {"Sweet potato", 1.6, 20, 0.1, 86},
    };
    QSqlQuery q(m_db);
    for (const Seed &s : seeds) {
        q.prepare("INSERT INTO foods (name, protein_per100g, carbs_per100g, fat_per100g, kcal_per100g) "
                  "VALUES (:name, :p, :c, :f, :kcal)");
        q.bindValue(":name", QString::fromUtf8(s.name));
        q.bindValue(":p", s.p);
        q.bindValue(":c", s.c);
        q.bindValue(":f", s.f);
        q.bindValue(":kcal", s.kcal);
        if (!q.exec())
            return false;
    }
    return true;
}

void StorageService::loadGoals()
{
    QSqlQuery q(m_db);
    if (q.exec("SELECT key, value FROM settings WHERE key IN ('goalProteinG','goalCarbsG','goalFatG')")) {
        while (q.next()) {
            QString k = q.value(0).toString();
            double v = q.value(1).toString().toDouble();
            if (k == "goalProteinG") m_goalProteinG = v;
            else if (k == "goalCarbsG") m_goalCarbsG = v;
            else if (k == "goalFatG") m_goalFatG = v;
        }
    }
}

void StorageService::loadFoods()
{
    m_foodListModel.clear();
    QSqlQuery q(m_db);
    if (!q.exec("SELECT id, name, protein_per100g, carbs_per100g, fat_per100g, kcal_per100g, unit FROM foods ORDER BY name"))
        return;
    while (q.next()) {
        auto *item = new FoodItem(this);
        item->setData(
            q.value(0).toInt(),
            q.value(1).toString(),
            q.value(2).toDouble(), q.value(3).toDouble(), q.value(4).toDouble(),
            q.value(5).toDouble(),
            q.value(6).toString().isEmpty() ? "g" : q.value(6).toString()
        );
        m_foodListModel.append(item);
    }
}

void StorageService::searchFoods(const QString &query)
{
    m_foodListModel.clear();
    QSqlQuery q(m_db);
    q.prepare("SELECT id, name, protein_per100g, carbs_per100g, fat_per100g, kcal_per100g, unit FROM foods "
              "WHERE name LIKE :q ORDER BY name");
    q.bindValue(":q", "%" + query.trimmed() + "%");
    if (!q.exec())
        return;
    while (q.next()) {
        auto *item = new FoodItem(this);
        item->setData(
            q.value(0).toInt(), q.value(1).toString(),
            q.value(2).toDouble(), q.value(3).toDouble(), q.value(4).toDouble(),
            q.value(5).toDouble(),
            q.value(6).toString().isEmpty() ? "g" : q.value(6).toString()
        );
        m_foodListModel.append(item);
    }
}

void StorageService::loadTodayLog()
{
    m_dailyLogModel.clear();
    QDate today = QDate::currentDate();
    QSqlQuery q(m_db);
    q.prepare("SELECT id, food_id, food_name, amount_g, protein_g, carbs_g, fat_g, kcal, logged_at, meal_type FROM daily_log WHERE log_date = :d ORDER BY meal_type, id");
    q.bindValue(":d", today.toString(Qt::ISODate));
    if (!q.exec())
        return;
    while (q.next()) {
        int mealType = qBound(0, q.value(9).toInt(), 3);
        auto *entry = new DailyLogEntry(this);
        entry->setData(
            q.value(0).toInt(), q.value(1).toInt(), q.value(2).toString(),
            q.value(3).toDouble(),
            q.value(4).toDouble(), q.value(5).toDouble(), q.value(6).toDouble(), q.value(7).toDouble(),
            q.value(8).toString(), mealType
        );
        m_dailyLogModel.append(entry);
    }
}

bool StorageService::addLogEntry(int foodId, double amountG, int mealType)
{
    if (amountG <= 0) return false;
    mealType = qBound(0, mealType, 3);
    QSqlQuery q(m_db);
    q.prepare("SELECT name, protein_per100g, carbs_per100g, fat_per100g, kcal_per100g FROM foods WHERE id = :id");
    q.bindValue(":id", foodId);
    if (!q.exec() || !q.next()) return false;
    QString name = q.value(0).toString();
    double p100 = q.value(1).toDouble(), c100 = q.value(2).toDouble(),
           f100 = q.value(3).toDouble(), k100 = q.value(4).toDouble();
    NutritionResult r = NutritionCalculator::compute(p100, c100, f100, k100, amountG);
    QString loggedAt = QDateTime::currentDateTime().toString(Qt::ISODate);
    q.prepare("INSERT INTO daily_log (log_date, food_id, food_name, amount_g, protein_g, carbs_g, fat_g, kcal, logged_at, meal_type) "
              "VALUES (:d, :fid, :fname, :amt, :p, :c, :f, :k, :at, :mt)");
    q.bindValue(":d", QDate::currentDate().toString(Qt::ISODate));
    q.bindValue(":fid", foodId);
    q.bindValue(":fname", name);
    q.bindValue(":amt", amountG);
    q.bindValue(":p", r.proteinG);
    q.bindValue(":c", r.carbsG);
    q.bindValue(":f", r.fatG);
    q.bindValue(":k", r.kcal);
    q.bindValue(":at", loggedAt);
    q.bindValue(":mt", mealType);
    if (!q.exec()) return false;
    int newId = q.lastInsertId().toInt();
    auto *entry = new DailyLogEntry(this);
    entry->setData(newId, foodId, name, amountG, r.proteinG, r.carbsG, r.fatG, r.kcal, loggedAt, mealType);
    m_dailyLogModel.append(entry);
    return true;
}

bool StorageService::removeLogEntryAt(int row)
{
    DailyLogEntry *e = m_dailyLogModel.entryAt(row);
    if (!e) return false;
    QSqlQuery q(m_db);
    q.prepare("DELETE FROM daily_log WHERE id = :id");
    q.bindValue(":id", e->id());
    if (!q.exec()) return false;
    m_dailyLogModel.removeAt(row);
    return true;
}

void StorageService::setGoalProteinG(double v)
{
    if (qFuzzyCompare(m_goalProteinG, v)) return;
    m_goalProteinG = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('goalProteinG', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit goalProteinGChanged();
}

void StorageService::setGoalCarbsG(double v)
{
    if (qFuzzyCompare(m_goalCarbsG, v)) return;
    m_goalCarbsG = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('goalCarbsG', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit goalCarbsGChanged();
}

void StorageService::setGoalFatG(double v)
{
    if (qFuzzyCompare(m_goalFatG, v)) return;
    m_goalFatG = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('goalFatG', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit goalFatGChanged();
}

void StorageService::setUserAge(int v)
{
    if (m_userAge == v) return;
    m_userAge = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userAge', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit userAgeChanged();
    emit hasBasicInfoChanged();
}

void StorageService::setUserHeightCm(double v)
{
    if (qFuzzyCompare(m_userHeightCm, v)) return;
    m_userHeightCm = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userHeightCm', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit userHeightCmChanged();
    emit hasBasicInfoChanged();
}

void StorageService::setUserWeightKg(double v)
{
    if (qFuzzyCompare(m_userWeightKg, v)) return;
    m_userWeightKg = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userWeightKg', :v)");
    q.bindValue(":v", QString::number(v));
    q.exec();
    emit userWeightKgChanged();
}

void StorageService::setUserIsMale(bool v)
{
    if (m_userIsMale == v) return;
    m_userIsMale = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userIsMale', :v)");
    q.bindValue(":v", v ? "1" : "0");
    q.exec();
    emit userIsMaleChanged();
    emit hasBasicInfoChanged();
}

void StorageService::setUserGoal(int v)
{
    int clamped = qBound(0, v, 4);
    if (m_userGoal == clamped) return;
    m_userGoal = clamped;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userGoal', :v)");
    q.bindValue(":v", QString::number(clamped));
    q.exec();
    emit userGoalChanged();
}

void StorageService::setUserActivityLevel(int v)
{
    int clamped = qBound(0, v, 2);
    if (m_userActivityLevel == clamped) return;
    m_userActivityLevel = clamped;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('userActivityLevel', :v)");
    q.bindValue(":v", QString::number(clamped));
    q.exec();
    emit userActivityLevelChanged();
}

void StorageService::setHasSeenOnboarding(bool v)
{
    if (m_hasSeenOnboarding == v) return;
    m_hasSeenOnboarding = v;
    QSqlQuery q(m_db);
    q.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES ('hasSeenOnboarding', :v)");
    q.bindValue(":v", v ? "1" : "0");
    q.exec();
    emit hasSeenOnboardingChanged();
}
