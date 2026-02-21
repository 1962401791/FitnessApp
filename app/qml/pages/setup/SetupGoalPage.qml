import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 5 (4.5): Goal selection. Lose Weight, Gain Weight, Muscle Mass, Improve Body, Other.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 5
    property int totalSteps: 8
    property bool isGuestMode: false

    readonly property var goalLabels: [
        qsTr("Lose Weight"),
        qsTr("Gain Weight"),
        qsTr("Muscle Mass Gain"),
        qsTr("Improve Body"),
        qsTr("Other")
    ]
    property int selectedGoal: storageService.userGoal

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingPage
        stepTitle: qsTr("What Is Your Goal?")
        stepSubtitle: qsTr("Choose the goal that best fits your fitness journey.")
        showBackButton: true
        buttonText: qsTr("Continue")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userGoal = root.selectedGoal
            flowPage.goNext()
        }

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Repeater {
                model: root.goalLabels.length
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    radius: 12
                    color: index === root.selectedGoal ? StyleConstants.primary : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: root.goalLabels[index]
                        font.pixelSize: 16
                        color: index === root.selectedGoal ? StyleConstants.textOnPrimary : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.selectedGoal = index
                    }
                }
            }
        }
    }
}
