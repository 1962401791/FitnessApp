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

    background: Rectangle { color: "#000000" }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: qsTr("Set Up")
        stepSubtitle: ""
        showBackButton: false
        buttonText: qsTr("Next")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onPrimaryClicked: flowPage.goNext()

        ColumnLayout {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 24

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 240
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                radius: 16
                color: StyleConstants.surfaceGray
                clip: true
                Image {
                    anchors.fill: parent
                    source: StyleConstants.onb1BgPath
                    fillMode: Image.PreserveAspectCrop
                }
            }

            Label {
                text: qsTr("Consistency Is The Key To Progress. Don't Give Up!")
                font.pixelSize: 16
                font.bold: true
                color: StyleConstants.accent
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
            }

            Label {
                text: qsTr("Track your workouts, set goals, and build habits that last. Every small step counts.")
                font.pixelSize: 12
                color: StyleConstants.textMuted
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
            }
        }
    }
}
