#ifndef IPOSECORRECTIONSERVICE_H
#define IPOSECORRECTIONSERVICE_H

#include <QObject>

/**
 * @brief Abstract interface for pose/action correction (e.g. exercise form).
 * Implementations may use camera + ML (e.g. ML Kit, ONNX) to compare user pose to reference.
 * This stub allows QML to depend on the interface; real implementation can be added later.
 */
class IPoseCorrectionService : public QObject
{
    Q_OBJECT

public:
    explicit IPoseCorrectionService(QObject *parent = nullptr) : QObject(parent) {}

    /** Start capture/analysis for a given exercise id. */
    Q_INVOKABLE virtual void startExercise(const QString &exerciseId) = 0;
    /** Stop capture. */
    Q_INVOKABLE virtual void stopExercise() = 0;
    /** Whether a session is active. */
    Q_INVOKABLE virtual bool isActive() const = 0;

signals:
    void correctionSuggested(const QString &message);
    void exerciseCompleted();
    void errorOccurred(const QString &error);
};

#endif // IPOSECORRECTIONSERVICE_H
