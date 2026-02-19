#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QString>
#include <QQuickStyle>
#include <QLocale>
#include <QTranslator>
#include "core/NutritionCalculator.h"
#include "models/FoodItem.h"
#include "models/DailyLogEntry.h"
#include "models/FoodListModel.h"
#include "models/DailyLogModel.h"
#include "services/StorageService.h"
#include "services/PoseCorrectionService.h"

int main(int argc, char *argv[])
{
    using namespace Qt::StringLiterals;
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");
    app.setApplicationName("HSport");
    app.setApplicationVersion("1.0.0");

    {
        const QString localeName = QLocale::system().name();
        QTranslator *translator = new QTranslator(&app);
        const QStringList candidates = { localeName, localeName.left(2) };
        for (const QString &candidate : candidates) {
            if (translator->load(QStringLiteral(":/i18n/hsport_%1.qm").arg(candidate))) {
                app.installTranslator(translator);
                break;
            }
        }
    }

    StorageService storage;
    if (!storage.init()) {
        qWarning("Storage init failed");
        return -1;
    }

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("storageService", &storage);
#ifdef QT_NO_DEBUG
    engine.rootContext()->setContextProperty("isDebugBuild", false);
#else
    engine.rootContext()->setContextProperty("isDebugBuild", true);
#endif

    qmlRegisterSingletonType<NutritionCalculator>("FitnessApp", 1, 0, "NutritionCalculator",
        [](QQmlEngine *, QJSEngine *) -> QObject * { return new NutritionCalculator; });
    qmlRegisterSingletonType<PoseCorrectionService>("FitnessApp", 1, 0, "PoseCorrectionService",
        [](QQmlEngine *, QJSEngine *) -> QObject * { return new PoseCorrectionService; });

    const QUrl url(u"qrc:/FitnessApp/qml/main.qml"_s);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
