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
        anchors.margins: StyleConstants.spacingPage
        stepTitle: qsTr("What Is Your Height?")
        stepSubtitle: qsTr("Used to calculate BMI and daily calorie needs.")
        showBackButton: true
        buttonText: qsTr("Continue")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userHeightCm = selectedHeightCm
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
                    color: root.useCm ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("CM")
                        font.pixelSize: StyleConstants.fontSizeSmall
                        font.bold: true
                        color: root.useCm ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useCm = true
                    }
                }
                Rectangle {
                    width: 70
                    height: 36
                    radius: StyleConstants.radiusUnitToggle
                    color: !root.useCm ? StyleConstants.accent : StyleConstants.surfaceGray
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("FT")
                        font.pixelSize: StyleConstants.fontSizeSmall
                        font.bold: true
                        color: !root.useCm ? StyleConstants.background : StyleConstants.textMuted
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.useCm = false
                    }
                }
            }

            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 6

                Label {
                    text: root.useCm
                        ? root.selectedHeightCm.toFixed(0)
                        : Math.floor(root.selectedHeightCm / 30.48).toString()
                    font.pixelSize: StyleConstants.fontSizeValueDisplay
                    font.bold: true
                    color: StyleConstants.textPrimary
                }
                Label {
                    text: root.useCm
                        ? qsTr("cm")
                        : qsTr("ft")
                    font.pixelSize: StyleConstants.fontSizeBody
                    font.bold: true
                    color: StyleConstants.textMuted
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: heightPicker
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(320, Math.max(220, root.height * 0.34))
                Layout.bottomMargin: 16
                property int minValue: 100
                property int maxValue: 250
                property int visibleTicks: 13
                property int itemHeight: Math.max(12, Math.min(26, Math.floor(heightScale.height / visibleTicks)))
                property bool syncFromList: false
                readonly property int count: maxValue - minValue + 1

                function updateFromList(index) {
                    var nextValue = minValue + index
                    if (nextValue !== root.selectedHeightCm) {
                        root.selectedHeightCm = nextValue
                    }
                }

                Rectangle {
                    id: heightTrack
                    width: 72
                    height: parent.height
                    radius: 16
                    color: StyleConstants.primary
                    opacity: 0.75
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                ListView {
                    id: heightScale
                    anchors.fill: heightTrack
                    anchors.margins: 10
                    orientation: ListView.Vertical
                    spacing: 0
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    snapMode: ListView.SnapToItem
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    preferredHighlightBegin: (height - heightPicker.itemHeight) / 2
                    preferredHighlightEnd: (height - heightPicker.itemHeight) / 2
                    model: heightPicker.count

                    delegate: Item {
                        width: heightTrack.width
                        height: heightPicker.itemHeight
                        property int value: heightPicker.minValue + index

                        Rectangle {
                            width: value % 5 === 0 ? 24 : 14
                            height: 2
                            radius: 1
                            color: StyleConstants.textPrimary
                            opacity: value % 5 === 0 ? 0.9 : 0.6
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    onCurrentIndexChanged: {
                        if (!heightPicker.syncFromList) {
                            heightPicker.updateFromList(currentIndex)
                        }
                    }
                }

                ListView {
                    id: heightLabels
                    width: 56
                    height: heightTrack.height
                    x: heightTrack.x - width - 16
                    y: heightTrack.y
                    orientation: ListView.Vertical
                    spacing: 0
                    clip: true
                    interactive: false
                    model: heightPicker.count
                    contentY: heightScale.contentY

                    delegate: Item {
                        width: heightLabels.width
                        height: heightPicker.itemHeight
                        property int value: heightPicker.minValue + index

                        Label {
                            anchors.fill: parent
                            text: value % 5 === 0 ? value.toString() : ""
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: value === Math.round(root.selectedHeightCm) ? StyleConstants.fontSizeTitle : StyleConstants.fontSizeBody
                            font.bold: value === Math.round(root.selectedHeightCm)
                            color: value === Math.round(root.selectedHeightCm) ? StyleConstants.textPrimary : StyleConstants.textMuted
                            rightPadding: 6
                        }
                    }
                }

                Rectangle {
                    width: 28
                    height: 2
                    radius: 1
                    color: StyleConstants.accent
                    anchors.verticalCenter: heightTrack.verticalCenter
                    x: heightTrack.x + (heightTrack.width - width) / 2
                }

                Canvas {
                    width: 12
                    height: 16
                    anchors.verticalCenter: heightTrack.verticalCenter
                    x: heightTrack.x + heightTrack.width + 10
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = StyleConstants.accent
                        ctx.beginPath()
                        ctx.moveTo(0, height / 2)
                        ctx.lineTo(width, 0)
                        ctx.lineTo(width, height)
                        ctx.closePath()
                        ctx.fill()
                    }
                }

                Connections {
                    target: root
                    function onSelectedHeightCmChanged() {
                        heightPicker.syncFromList = true
                        heightScale.currentIndex = Math.round(root.selectedHeightCm) - heightPicker.minValue
                        heightPicker.syncFromList = false
                    }
                }
            }
        }
    }
}
