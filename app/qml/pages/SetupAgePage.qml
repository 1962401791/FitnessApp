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

    background: Rectangle { color: "#000000" }

    Component.onCompleted: {
        if (storageService.userAge <= 0)
            storageService.userAge = 28
        selectedAge = storageService.userAge
    }

    SetupStepLayout {
        anchors.fill: parent
        anchors.margins: 20
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
                font.pixelSize: 64
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
                property int itemWidth: 64
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
                    y: 40
                    width: parent.width - 32
                    height: 52
                    radius: 26
                    color: StyleConstants.primary
                    opacity: 0.8
                }

                Canvas {
                    id: ageArrow
                    width: 16
                    height: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 22
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
                    anchors.margins: 8
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
                            y: -2
                            text: value
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            topPadding: 0
                            bottomPadding: 0
                            leftPadding: 0
                            rightPadding: 0
                            lineHeight: parent.height
                            lineHeightMode: Text.FixedHeight
                            font.pixelSize: value === root.selectedAge ? 20 : 16
                            font.bold: value === root.selectedAge
                            color: value === root.selectedAge ? "#FFFFFF" : "#3A3A3A"
                        }
                    }

                    onCurrentIndexChanged: agePicker.updateFromList(currentIndex)
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: ageTrack.y
                    width: 2
                    height: ageTrack.height
                    radius: 1
                    color: "#FFFFFF"
                    opacity: 0.6
                    x: ageTrack.x + ageTrack.width / 2 - agePicker.itemWidth / 2 - width / 2
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: ageTrack.y
                    width: 2
                    height: ageTrack.height
                    radius: 1
                    color: "#FFFFFF"
                    opacity: 0.6
                    x: ageTrack.x + ageTrack.width / 2 + agePicker.itemWidth / 2 - width / 2
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
