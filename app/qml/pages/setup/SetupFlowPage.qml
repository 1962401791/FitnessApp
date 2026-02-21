import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup flow container: guest mode (5 steps) or login mode (8 steps).
 * Guest: Intro → Gender → Age → Weight → Height → HomePage
 * Login: (optional skip) Intro → Gender → Age → Weight → Height → Goal → Activity → Profile → HomePage
 */
Page {
    id: root
    property Item stackView
    property bool isGuestMode: true
    property int startStep: 0
    property bool initialStepPushed: false

    readonly property int guestStepCount: 5
    readonly property int loginStepCount: 8
    readonly property int totalSteps: isGuestMode ? guestStepCount : loginStepCount
    property int currentStep: 0

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    function goBack() {
        if (currentStep <= 0) {
            stackView.pop()
            stackView.pop()
        } else {
            currentStep = currentStep - 1
            stackView.pop()
        }
    }

    function goNext() {
        if (currentStep + 1 >= totalSteps) {
            finishSetup()
            return
        }
        currentStep = currentStep + 1
        var component = stepComponent(currentStep)
        if (component) {
            var props = {
                stackView: stackView,
                flowPage: root,
                stepIndex: currentStep,
                totalSteps: totalSteps,
                isGuestMode: root.isGuestMode
            }
            stackView.push(component, props)
        }
    }

    function stepComponent(stepIndex) {
        var steps = [
            "qrc:/FitnessApp/qml/pages/setup/SetupIntroPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupGenderPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupAgePage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupWeightPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupHeightPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupGoalPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupActivityPage.qml",
            "qrc:/FitnessApp/qml/pages/setup/SetupProfilePage.qml"
        ]
        return stepIndex >= 0 && stepIndex < steps.length ? steps[stepIndex] : null
    }

    function finishSetup() {
        if (!storageService.hasBasicInfo && storageService.userHeightCm <= 0) {
            storageService.userHeightCm = 170
        }
        stackView.replace("qrc:/FitnessApp/qml/pages/main/HomePage.qml", { stackView: stackView })
    }

    function pushInitialStep() {
        if (initialStepPushed) {
            return
        }
        initialStepPushed = true
        currentStep = startStep
        var comp = stepComponent(startStep)
        if (comp) {
            var props = {
                stackView: stackView,
                flowPage: root,
                stepIndex: startStep,
                totalSteps: totalSteps,
                isGuestMode: root.isGuestMode
            }
            stackView.push(comp, props)
        }
    }

    Component.onCompleted: {
        currentStep = startStep
    }

    StackView.onStatusChanged: {
        if (StackView.status === StackView.Active) {
            pushInitialStep()
        }
    }

}
