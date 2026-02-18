#include "services/PoseCorrectionService.h"

PoseCorrectionService::PoseCorrectionService(QObject *parent)
    : IPoseCorrectionService(parent) {}

void PoseCorrectionService::startExercise(const QString &exerciseId)
{
    Q_UNUSED(exerciseId);
    m_active = true;
    // Stub: no camera/ML yet; emit error so UI can show "coming soon"
    emit errorOccurred("Pose correction is not implemented yet.");
}

void PoseCorrectionService::stopExercise()
{
    m_active = false;
}
