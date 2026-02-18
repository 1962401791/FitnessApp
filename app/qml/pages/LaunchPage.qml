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
        stackView.replace("qrc:/FitnessApp/qml/pages/ModeSelectPage.qml", { stackView: stackView })
    }

    function goToOnboarding() {
        stackView.replace("qrc:/FitnessApp/qml/pages/OnboardingPage.qml", { stackView: stackView })
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
                text: "欢迎使用"
                font.pixelSize: 18
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 120
                height: 120
                radius: 24
                color: StyleConstants.primary
                Image {
                    anchors.centerIn: parent
                    source: StyleConstants.logoPathPng
                    sourceSize.width: 80
                    sourceSize.height: 80
                    width: 80
                    height: 80
                    fillMode: Image.PreserveAspectFit
                }
            }

            Label {
                text: "HSport"
                font.pixelSize: 36
                font.bold: true
                color: StyleConstants.accent
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "健康生活 · 健身融入每一天"
                font.pixelSize: 14
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
