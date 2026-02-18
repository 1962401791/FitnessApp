#ifndef POSECORRECTIONSERVICE_H
#define POSECORRECTIONSERVICE_H

#include <QtQml/qqmlregistration.h>
#include "IPoseCorrectionService.h"

/**
 * @brief No-op implementation of IPoseCorrectionService for extensibility.
 * Replace with real camera/ML implementation later.
 */
class PoseCorrectionService : public IPoseCorrectionService
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit PoseCorrectionService(QObject *parent = nullptr);

    void startExercise(const QString &exerciseId) override;
    void stopExercise() override;
    bool isActive() const override { return m_active; }

private:
    bool m_active = false;
};

#endif // POSECORRECTIONSERVICE_H
