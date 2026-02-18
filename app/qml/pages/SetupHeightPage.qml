import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 4 (4.4): Height picker with CM/FT unit toggle. Login mode only.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 4
    property int totalSteps: 8
    property bool isGuestMode: false

    property bool useCm: true
    property double selectedHeightCm: storageService.userHeightCm > 0 ? storageService.userHeightCm : 165

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    Component.onCompleted: {
        if (storageService.userHeightCm <= 0)
            storageService.userHeightCm = 165
        selectedHeightCm = storageService.userHeightCm
    }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "What Is Your Height?"
        stepSubtitle: "Used to calculate BMI and daily calorie needs."
        showBackButton: true
        buttonText: "Continue"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userHeightCm = selectedHeightCm
            flowPage.goNext()
        }

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 8
                Rectangle {
                    width: 80
                    height: 40
                    radius: 20
                    color: root.useCm ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: "CM"
                        font.pixelSize: 14
                        color: root.useCm ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useCm = true
                    }
                }
                Rectangle {
                    width: 80
                    height: 40
                    radius: 20
                    color: !root.useCm ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: "FT"
                        font.pixelSize: 14
                        color: !root.useCm ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useCm = false
                    }
                }
            }

            Label {
                text: root.useCm
                    ? (root.selectedHeightCm.toFixed(0) + " cm")
                    : (Math.floor(root.selectedHeightCm / 30.48) + "' " + Math.round((root.selectedHeightCm % 30.48) / 2.54) + "\"")
                font.pixelSize: 36
                font.bold: true
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            Slider {
                Layout.fillWidth: true
                from: root.useCm ? 100 : 3.28
                to: root.useCm ? 250 : 8.2
                value: root.useCm ? root.selectedHeightCm : root.selectedHeightCm / 30.48
                stepSize: root.useCm ? 1 : 0.01
                onValueChanged: {
                    if (root.useCm)
                        root.selectedHeightCm = Math.round(value)
                    else
                        root.selectedHeightCm = Math.round(value * 30.48)
                }
            }
        }
    }
}
