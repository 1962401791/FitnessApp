import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("每日总结")
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    Flickable {
        anchors.fill: parent
        contentHeight: col.implicitHeight + StyleConstants.spacingLarge * 2
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: col
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: StyleConstants.spacingLarge
            spacing: StyleConstants.spacingMedium

            RowLayout {
                Layout.fillWidth: true
                Button {
                    text: "←"
                    flat: true
                    onClicked: stackView.pop()
                }
                Label {
                    text: qsTr("今日总结")
                    font.pixelSize: StyleConstants.fontSizeTitle
                    Layout.fillWidth: true
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                radius: StyleConstants.radiusLarge
                color: StyleConstants.primary
                ColumnLayout {
                    anchors.centerIn: parent
                    Label {
                        text: qsTr("%1 kcal").arg(storageService.dailyLogModel.totalKcal.toFixed(0))
                        font.pixelSize: StyleConstants.fontSizeDisplay
                        font.bold: true
                        color: StyleConstants.textOnPrimary
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Label {
                        text: qsTr("今日摄入")
                        font.pixelSize: StyleConstants.fontSizeSmall
                        color: StyleConstants.primaryLight
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            NutrientBar {
                label: qsTr("蛋白质")
                value: storageService.dailyLogModel.totalProteinG
                goal: storageService.goalProteinG
                barColor: StyleConstants.primary
                Layout.fillWidth: true
            }
            NutrientBar {
                label: qsTr("碳水")
                value: storageService.dailyLogModel.totalCarbsG
                goal: storageService.goalCarbsG
                barColor: StyleConstants.accent
                Layout.fillWidth: true
            }
            NutrientBar {
                label: qsTr("脂肪")
                value: storageService.dailyLogModel.totalFatG
                goal: storageService.goalFatG
                barColor: StyleConstants.primaryLight
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("BMR 与运动消耗：待实现")
                font.pixelSize: StyleConstants.fontSizeSmall
                color: StyleConstants.textMuted
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("返回")
                Layout.fillWidth: true
                onClicked: stackView.pop()
            }
        }
    }
}
