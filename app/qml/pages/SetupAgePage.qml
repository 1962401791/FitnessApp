import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 2 (4.2): Age picker. Horizontal wheel-style selection.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 2
    property int totalSteps: 4
    property bool isGuestMode: true

    property int selectedAge: storageService.userAge > 0 ? storageService.userAge : 28

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    Component.onCompleted: {
        if (storageService.userAge <= 0)
            storageService.userAge = 28
        selectedAge = storageService.userAge
    }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "How Old Are You?"
        stepSubtitle: "Your age helps us calculate your daily calorie needs."
        showBackButton: true
        buttonText: "Continue"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userAge = selectedAge
            flowPage.goNext()
        }

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 24

            Label {
                text: selectedAge.toString()
                font.pixelSize: 48
                font.bold: true
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            Slider {
                Layout.fillWidth: true
                from: 10
                to: 120
                value: root.selectedAge
                stepSize: 1
                onValueChanged: root.selectedAge = Math.round(value)
            }
        }
    }
}
