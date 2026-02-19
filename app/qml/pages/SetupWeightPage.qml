import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 3 (4.3): Weight picker with KG/LB unit toggle.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 3
    property int totalSteps: 4
    property bool isGuestMode: true

    property bool useKg: true
    property double selectedWeightKg: storageService.userWeightKg > 0 ? storageService.userWeightKg : 75

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    Component.onCompleted: {
        if (storageService.userWeightKg <= 0)
            storageService.userWeightKg = 75
        selectedWeightKg = storageService.userWeightKg
    }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
        stepTitle: qsTr("What Is Your Weight?")
        stepSubtitle: qsTr("We use this to calculate your calorie and macro goals.")
        showBackButton: true
        buttonText: qsTr("Continue")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userWeightKg = selectedWeightKg
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
                    color: root.useKg ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("KG")
                        font.pixelSize: 14
                        color: root.useKg ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useKg = true
                    }
                }
                Rectangle {
                    width: 80
                    height: 40
                    radius: 20
                    color: !root.useKg ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("LB")
                        font.pixelSize: 14
                        color: !root.useKg ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useKg = false
                    }
                }
            }

            Label {
                text: root.useKg
                    ? qsTr("%1 kg").arg(root.selectedWeightKg.toFixed(0))
                    : qsTr("%1 lb").arg(Math.round(root.selectedWeightKg * 2.205).toString())
                font.pixelSize: 36
                font.bold: true
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            Slider {
                Layout.fillWidth: true
                from: root.useKg ? 30 : 66
                to: root.useKg ? 200 : 440
                value: root.useKg ? root.selectedWeightKg : root.selectedWeightKg * 2.205
                stepSize: root.useKg ? 1 : 1
                onValueChanged: {
                    if (root.useKg)
                        root.selectedWeightKg = Math.round(value)
                    else
                        root.selectedWeightKg = Math.round(value / 2.205 * 10) / 10
                }
            }
        }
    }
}
