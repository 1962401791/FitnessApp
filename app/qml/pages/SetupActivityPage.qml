import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 6 (4.6): Physical activity level. Beginner, Intermediate, Advance.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 6
    property int totalSteps: 8
    property bool isGuestMode: false

    readonly property var levelLabels: ["Beginner", "Intermediate", "Advance"]
    property int selectedLevel: storageService.userActivityLevel

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "Physical Activity Level"
        stepSubtitle: "How active are you in your daily life?"
        showBackButton: true
        buttonText: "Continue"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userActivityLevel = root.selectedLevel
            flowPage.goNext()
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            Repeater {
                model: root.levelLabels.length
                Rectangle {
                    width: 100
                    height: 52
                    radius: 12
                    color: index === root.selectedLevel ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: root.levelLabels[index]
                        font.pixelSize: 14
                        color: index === root.selectedLevel ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.selectedLevel = index
                    }
                }
            }
        }
    }
}
