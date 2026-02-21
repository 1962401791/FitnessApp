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
        anchors.margins: StyleConstants.spacingPage
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
            width: parent.width - 64
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 32

            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 8
                Rectangle {
                    width: 70
                    height: 36
                    radius: StyleConstants.radiusUnitToggle
                    color: root.useKg ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("KG")
                        font.pixelSize: StyleConstants.fontSizeSmall
                        font.bold: true
                        color: root.useKg ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useKg = true
                    }
                }
                Rectangle {
                    width: 70
                    height: 36
                    radius: StyleConstants.radiusUnitToggle
                    color: !root.useKg ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("LB")
                        font.pixelSize: StyleConstants.fontSizeSmall
                        font.bold: true
                        color: !root.useKg ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useKg = false
                    }
                }
            }

            Item {
                id: weightPicker
                Layout.fillWidth: true
                Layout.preferredHeight: 160
                property int minKg: 30
                property int maxKg: 200
                property int minLb: 66
                property int maxLb: 440
                property int itemWidth: 52
                property bool syncFromList: false
                readonly property int unitMin: root.useKg ? minKg : minLb
                readonly property int unitMax: root.useKg ? maxKg : maxLb
                readonly property real unitValue: root.useKg ? root.selectedWeightKg : root.selectedWeightKg * 2.205
                readonly property int unitCount: unitMax - unitMin + 1

                function updateFromList(index) {
                    var nextUnitValue = unitMin + index
                    if (root.useKg) {
                        root.selectedWeightKg = nextUnitValue
                    } else {
                        root.selectedWeightKg = Math.round(nextUnitValue / 2.205 * 10) / 10
                    }
                }

                onVisibleChanged: {
                    if (visible) {
                        weightList.currentIndex = Math.round(unitValue) - unitMin
                    }
                }

                ListView {
                    id: weightNumbers
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 0
                    width: parent.width - 32
                    height: 28
                    orientation: ListView.Horizontal
                    spacing: 0
                    clip: true
                    interactive: false
                    model: weightPicker.unitCount
                    contentX: weightList.contentX

                    delegate: Item {
                        width: weightPicker.itemWidth
                        height: weightNumbers.height
                        property int value: weightPicker.unitMin + index

                        Label {
                            anchors.fill: parent
                            text: value
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: value === Math.round(weightPicker.unitValue) ? StyleConstants.fontSizeTitle : StyleConstants.fontSizeBody
                            font.bold: value === Math.round(weightPicker.unitValue)
                            color: value === Math.round(weightPicker.unitValue) ? StyleConstants.textPrimary : StyleConstants.textMuted
                        }
                    }
                }

                Rectangle {
                    id: weightTrack
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: weightNumbers.y + weightNumbers.height + 10
                    width: parent.width - 32
                    height: 48
                    radius: 24
                    color: StyleConstants.primary
                    opacity: 0.75
                }

                ListView {
                    id: weightList
                    anchors.fill: weightTrack
                    anchors.margins: 8
                    orientation: ListView.Horizontal
                    spacing: 0
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    snapMode: ListView.SnapToItem
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    preferredHighlightBegin: (width - weightPicker.itemWidth) / 2
                    preferredHighlightEnd: (width - weightPicker.itemWidth) / 2
                    model: weightPicker.unitCount

                    delegate: Item {
                        width: weightPicker.itemWidth
                        height: weightTrack.height
                        property int value: weightPicker.unitMin + index

                        Rectangle {
                            width: 2
                            height: value % 5 === 0 ? 18 : 10
                            radius: 1
                            color: StyleConstants.textPrimary
                            opacity: value % 5 === 0 ? 0.8 : 0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    onCurrentIndexChanged: {
                        if (!weightPicker.syncFromList) {
                            weightPicker.updateFromList(currentIndex)
                        }
                    }
                }

                Rectangle {
                    width: 2
                    height: weightTrack.height
                    radius: 1
                    color: StyleConstants.accent
                    anchors.horizontalCenter: weightTrack.horizontalCenter
                    y: weightTrack.y
                }

                Canvas {
                    width: 18
                    height: 12
                    anchors.horizontalCenter: weightTrack.horizontalCenter
                    y: weightTrack.y + weightTrack.height + 6
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = StyleConstants.accent
                        ctx.beginPath()
                        ctx.moveTo(width / 2, 0)
                        ctx.lineTo(width, height)
                        ctx.lineTo(0, height)
                        ctx.closePath()
                        ctx.fill()
                    }
                }

                Connections {
                    target: root
                    function onSelectedWeightKgChanged() {
                        if (!weightPicker.syncFromList) {
                            weightPicker.syncFromList = true
                            weightList.currentIndex = Math.round(weightPicker.unitValue) - weightPicker.unitMin
                            weightPicker.syncFromList = false
                        }
                    }
                    function onUseKgChanged() {
                        weightPicker.syncFromList = true
                        weightList.currentIndex = Math.round(weightPicker.unitValue) - weightPicker.unitMin
                        weightPicker.syncFromList = false
                    }
                }
            }

            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 6

                Label {
                    text: root.useKg
                        ? root.selectedWeightKg.toFixed(0)
                        : Math.round(root.selectedWeightKg * 2.205).toString()
                    font.pixelSize: StyleConstants.fontSizeValueDisplay
                    font.bold: true
                    color: StyleConstants.textPrimary
                }
                Label {
                    text: root.useKg ? qsTr("kg") : qsTr("lb")
                    font.pixelSize: StyleConstants.fontSizeBody
                    font.bold: true
                    color: StyleConstants.textMuted
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
