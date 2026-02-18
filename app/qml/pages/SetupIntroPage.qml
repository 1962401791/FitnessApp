import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 0 (4-A): Intro screen with hero image, motivational text, Next button.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 0
    property int totalSteps: 4
    property bool isGuestMode: true

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "Set Up"
        stepSubtitle: ""
        showBackButton: false
        buttonText: "Next"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onPrimaryClicked: flowPage.goNext()

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                radius: 16
                color: StyleConstants.surfaceGray
                Image {
                    anchors.fill: parent
                    source: StyleConstants.onb1BgPath
                    fillMode: Image.PreserveAspectCrop
                }
            }

            Label {
                text: "Consistency Is The Key To Progress. Don't Give Up!"
                font.pixelSize: 18
                font.bold: true
                color: StyleConstants.accent
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Label {
                text: "Track your workouts, set goals, and build habits that last. Every small step counts."
                font.pixelSize: 13
                color: StyleConstants.textMuted
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
        }
    }
}
