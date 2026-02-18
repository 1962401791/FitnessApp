import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: "饮食记录"
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingMedium
        spacing: StyleConstants.spacingMedium

        RowLayout {
            Layout.fillWidth: true
            Button {
                text: "←"
                flat: true
                onClicked: stackView.pop()
            }
            Label {
                text: "今日饮食"
                font.pixelSize: StyleConstants.fontSizeTitle
                Layout.fillWidth: true
            }
            Button {
                text: "添加"
                flat: true
                font.bold: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/AddFoodPage.qml", { stackView: stackView })
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            radius: StyleConstants.radiusMedium
            color: StyleConstants.backgroundSecondary
            RowLayout {
                anchors.fill: parent
                anchors.margins: StyleConstants.spacingSmall
                Label {
                    text: "P " + storageService.dailyLogModel.totalProteinG.toFixed(0) + "  C " + storageService.dailyLogModel.totalCarbsG.toFixed(0) + "  F " + storageService.dailyLogModel.totalFatG.toFixed(0) + "  " + storageService.dailyLogModel.totalKcal.toFixed(0) + " kcal"
                    font.pixelSize: StyleConstants.fontSizeSmall
                    color: StyleConstants.textPrimary
                }
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: availableWidth
            clip: true
            ListView {
                model: storageService.dailyLogModel
                delegate: FoodEntryRow {
                    width: ListView.view.width - 20
                    foodName: model.foodName
                    amountG: model.amountG
                    proteinG: model.proteinG
                    carbsG: model.carbsG
                    fatG: model.fatG
                    kcal: model.kcal
                    onRemove: storageService.removeLogEntryAt(index)
                }
            }
        }
    }
}
