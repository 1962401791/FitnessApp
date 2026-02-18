import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 7 (4.7): Fill profile - avatar, Full Name, Username, Email, Password.
 * Login mode final step. Beta: form not persisted, Start completes flow.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 7
    property int totalSteps: 8
    property bool isGuestMode: false

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: "Fill Your Profile"
        stepSubtitle: "Add your details to personalize your experience."
        showBackButton: true
        buttonText: "Start"
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: flowPage.goNext()

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 120
                height: 120
                radius: 60
                color: StyleConstants.primary
                Rectangle {
                    anchors.centerIn: parent
                    width: 100
                    height: 100
                    radius: 50
                    color: StyleConstants.surfaceGray
                }
                Text {
                    anchors.centerIn: parent
                    text: "\u2795"
                    font.pixelSize: 32
                    color: StyleConstants.textMuted
                }
            }

            TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                placeholderText: "Full Name"
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                background: Rectangle {
                    radius: 12
                    color: StyleConstants.surfaceGray
                }
            }

            TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                placeholderText: "Username"
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                background: Rectangle {
                    radius: 12
                    color: StyleConstants.surfaceGray
                }
            }

            TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                placeholderText: "Email"
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                inputMethodHints: Qt.ImhEmailCharactersOnly
                background: Rectangle {
                    radius: 12
                    color: StyleConstants.surfaceGray
                }
            }

            TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                placeholderText: "Password"
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                echoMode: TextInput.Password
                background: Rectangle {
                    radius: 12
                    color: StyleConstants.surfaceGray
                }
            }

            TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                placeholderText: "Confirm Password"
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                echoMode: TextInput.Password
                background: Rectangle {
                    radius: 12
                    color: StyleConstants.surfaceGray
                }
            }
        }
    }
}
