import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 1 (4.1): Gender selection. Male/Female buttons with icons.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 1
    property int totalSteps: 4
    property bool isGuestMode: true

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "What's Your Gender"
        stepSubtitle: "This helps us personalize your experience and recommendations."
        showBackButton: true
        buttonText: "Continue"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: flowPage.goNext()

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Rectangle {
                width: 140
                height: 160
                radius: 80
                color: storageService.userIsMale ? StyleConstants.accent : StyleConstants.surfaceGray
                Column {
                    anchors.centerIn: parent
                    spacing: 8
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "\u2642"
                        font.pixelSize: 48
                        color: storageService.userIsMale ? StyleConstants.background : StyleConstants.textMuted
                    }
                    Label {
                        text: "Male"
                        font.pixelSize: 16
                        color: storageService.userIsMale ? StyleConstants.background : StyleConstants.textMuted
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: storageService.userIsMale = true
                }
            }

            Rectangle {
                width: 140
                height: 160
                radius: 80
                color: !storageService.userIsMale ? StyleConstants.accent : StyleConstants.surfaceGray
                Column {
                    anchors.centerIn: parent
                    spacing: 8
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "\u2640"
                        font.pixelSize: 48
                        color: !storageService.userIsMale ? StyleConstants.background : StyleConstants.textMuted
                    }
                    Label {
                        text: "Female"
                        font.pixelSize: 16
                        color: !storageService.userIsMale ? StyleConstants.background : StyleConstants.textMuted
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: storageService.userIsMale = false
                }
            }
        }
    }
}
