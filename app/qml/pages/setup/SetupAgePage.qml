import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Setup step 2 (4.2): Age picker. Horizontal wheel-style selection.
 */
Page {
    id: root
    property Item stackView
    property var flowPage
    property int stepIndex: 2
    property int totalSteps: 4
    property bool isGuestMode: true

    property int selectedAge: storageService.userAge > 0 ? storageService.userAge : 28

    background: Rectangle { color: StyleConstants.backgroundSecondary }

    Component.onCompleted: {
        if (storageService.userAge <= 0)
            storageService.userAge = 28
        selectedAge = storageService.userAge
    }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingPage
        stepTitle: qsTr("How Old Are You?")
        stepSubtitle: qsTr("Your age helps us calculate your daily calorie needs.")
        showBackButton: true
        buttonText: qsTr("Continue")
        progressStep: stepIndex
        progressTotal: totalSteps
        canProceed: true

        onBackClicked: flowPage.goBack()
        onPrimaryClicked: {
            storageService.userAge = selectedAge
            flowPage.goNext()
        }

        ColumnLayout {
            width: parent.width - 64
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 40

            Label {
                text: selectedAge.toString()
                font.pixelSize: StyleConstants.fontSizeAgeDisplay
                font.bold: true
                color: StyleConstants.textPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            Item {
                id: agePicker
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                property int minAge: 10
                property int maxAge: 120
                property int trackWidth: Math.min(280, Math.max(200, Math.floor(parent.width * 0.62)))
                property int trackHeight: 56
                property int itemWidth: Math.floor(trackWidth / 3)
                property bool syncFromList: false

                function updateFromList(index) {
                    var nextValue = minAge + index
                    if (nextValue !== root.selectedAge) {
                        syncFromList = true
                        root.selectedAge = nextValue
                        syncFromList = false
                    }
                }

                onVisibleChanged: {
                    if (visible) {
                        ageList.currentIndex = root.selectedAge - minAge
                    }
                }

                Rectangle {
                    id: ageTrack
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 44
                    width: agePicker.trackWidth
                    height: agePicker.trackHeight
                    radius: height / 2
                    color: StyleConstants.primary
                    opacity: 0.8
                }

                Canvas {
                    id: ageArrow
                    width: 14
                    height: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: ageTrack.y - height - 6
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = StyleConstants.accent
                        ctx.beginPath()
                        ctx.moveTo(width / 2, height)
                        ctx.lineTo(0, 0)
                        ctx.lineTo(width, 0)
                        ctx.closePath()
                        ctx.fill()
                    }
                }

                ListView {
                    id: ageList
                    anchors.fill: ageTrack
                    anchors.margins: 0
                    orientation: ListView.Horizontal
                    spacing: 0
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    snapMode: ListView.SnapToItem
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    preferredHighlightBegin: (width - agePicker.itemWidth) / 2
                    preferredHighlightEnd: (width - agePicker.itemWidth) / 2
                    model: agePicker.maxAge - agePicker.minAge + 1

                    delegate: Item {
                        width: agePicker.itemWidth
                        height: ageTrack.height
                        property int value: agePicker.minAge + index

                        Label {
                            anchors.fill: parent
                            y: -1
                            text: value
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            topPadding: 0
                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0
                            lineHeight: parent.height
                            lineHeightMode: Text.FixedHeight
                            font.pixelSize: value === root.selectedAge ? StyleConstants.fontSizeTitle : StyleConstants.fontSizeBody
                            font.bold: value === root.selectedAge
                            color: value === root.selectedAge ? StyleConstants.textPrimary : StyleConstants.textMuted
                        }
                    }

                    onCurrentIndexChanged: agePicker.updateFromList(currentIndex)
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 2
                    height: ageTrack.height - 16
                    radius: 1
                    color: StyleConstants.textPrimary
                    opacity: 0.7
                    x: ageTrack.x + (ageTrack.width - width) / 2
                    y: ageTrack.y + 8
                }

                Connections {
                    target: root
                    function onSelectedAgeChanged() {
                        if (!agePicker.syncFromList) {
                            ageList.currentIndex = root.selectedAge - agePicker.minAge
                        }
                    }
                }
            }
        }
    }
}
