import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Launch / Splash: 1:1 with HSport.pen 1-Launch.
 * Full-bleed launch_bg.png, logo in purple frame, white/accent text.
 */
Page {
    id: root
    property Item stackView
    background: Item {}

    Component.onCompleted: {
        Qt.callLater(function() {
            if (typeof isDebugBuild !== "undefined" && isDebugBuild) {
                launchTimer.start()
            } else if (storageService.hasSeenOnboarding) {
                goToModeSelect()
            } else {
                launchTimer.start()
            }
        })
    }

    function goToModeSelect() {
        stackView.replace("qrc:/FitnessApp/qml/pages/onboarding/ModeSelectPage.qml", { stackView: stackView })
    }

    function goToOnboarding() {
        stackView.replace("qrc:/FitnessApp/qml/pages/onboarding/OnboardingPage.qml", { stackView: stackView })
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            launchTimer.stop()
            if (typeof isDebugBuild !== "undefined" && isDebugBuild)
                goToOnboarding()
            else if (storageService.hasSeenOnboarding)
                goToModeSelect()
            else
                goToOnboarding()
        }
    }

    Timer {
        id: launchTimer
        interval: 2200
        repeat: false
        onTriggered: goToOnboarding()
    }

    Item {
        anchors.fill: parent

        Image {
            id: bgImage
            anchors.fill: parent
            source: StyleConstants.launchBgPath
            fillMode: Image.PreserveAspectCrop
        }
        Rectangle {
            anchors.fill: parent
            visible: bgImage.status !== Image.Ready
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#1A1A2E" }
                GradientStop { position: 0.5; color: "#16213E" }
                GradientStop { position: 1.0; color: "#0F0F1A" }
            }
        }

        ColumnLayout {
            anchors.centerIn: parent
            width: Math.min(parent.width * 0.85, 320)
            spacing: 24

            Label {
                text: qsTr("欢迎使用")
                font.pixelSize: 18
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                Layout.alignment: Qt.AlignHCenter
                source: StyleConstants.logoPath
                sourceSize.width: 120
                sourceSize.height: 120
                width: 120
                height: 120
                fillMode: Image.PreserveAspectFit
            }

            Label {
                text: qsTr("HSport")
                font.pixelSize: 36
                font.bold: true
                color: StyleConstants.accent
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: qsTr("健康生活 · 健身融入每一天")
                font.pixelSize: 14
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
