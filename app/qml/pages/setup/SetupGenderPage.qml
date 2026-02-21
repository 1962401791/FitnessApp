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
        anchors.margins: StyleConstants.spacingPage
        stepTitle: qsTr("What's Your Gender")
        stepSubtitle: qsTr("This helps us personalize your experience and recommendations.")
        showBackButton: true
        buttonText: qsTr("Continue")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: flowPage.goNext()

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 24

            Rectangle {
                width: 150
                height: 150
                radius: 75
                color: storageService.userIsMale ? StyleConstants.surfaceGray : StyleConstants.cardBackground
                border.width: storageService.userIsMale ? 0 : 1
                border.color: StyleConstants.surfaceGray
                Column {
                    anchors.centerIn: parent
                    spacing: 12
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "\u2642"
                        font.pixelSize: 56
                        color: storageService.userIsMale ? StyleConstants.textPrimary : StyleConstants.textMuted
                    }
                    Label {
                        text: qsTr("Male")
                        font.pixelSize: 14
                        color: storageService.userIsMale ? StyleConstants.textPrimary : StyleConstants.textMuted
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: storageService.userIsMale = true
                }
            }

            Rectangle {
                width: 150
                height: 150
                radius: 75
                color: !storageService.userIsMale ? StyleConstants.accent : StyleConstants.cardBackground
                border.width: !storageService.userIsMale ? 0 : 1
                border.color: StyleConstants.surfaceGray
                Column {
                    anchors.centerIn: parent
                    spacing: 12
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "\u2640"
                        font.pixelSize: 56
                        color: !storageService.userIsMale ? StyleConstants.background : StyleConstants.textMuted
                    }
                    Label {
                        text: qsTr("Female")
                        font.pixelSize: 14
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
