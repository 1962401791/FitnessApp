import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("饮食记录")
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingMedium
        spacing: StyleConstants.spacingMedium

        RowLayout {
            Layout.fillWidth: true
            Button {
                icon.source: StyleConstants.iconArrowLeftPath
                icon.width: 24
                icon.height: 24
                display: AbstractButton.IconOnly
                flat: true
                onClicked: stackView.pop()
            }
            Label {
                text: qsTr("今日饮食")
                font.pixelSize: StyleConstants.fontSizeTitle
                Layout.fillWidth: true
            }
        }

        MacroSummary {
            Layout.fillWidth: true
            proteinG: storageService.dailyLogModel.totalProteinG
            carbsG: storageService.dailyLogModel.totalCarbsG
            fatG: storageService.dailyLogModel.totalFatG
            totalKcal: storageService.dailyLogModel.totalKcal
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: StyleConstants.spacingSmall
            Repeater {
                model: [
                    { icon: StyleConstants.iconBreakfastPath, label: qsTr("早餐"), mealType: 0 },
                    { icon: StyleConstants.iconLunchPath, label: qsTr("中餐"), mealType: 1 },
                    { icon: StyleConstants.iconDinnerPath, label: qsTr("晚餐"), mealType: 2 },
                    { icon: StyleConstants.iconSnackPath, label: qsTr("加餐"), mealType: 3 }
                ]
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 56
                    radius: StyleConstants.radiusSmall
                    color: mouse.pressed ? StyleConstants.primaryPale : StyleConstants.cardBackground
                    border.width: 1
                    border.color: StyleConstants.divider
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: StyleConstants.spacingXs
                        Icon {
                            Layout.alignment: Qt.AlignHCenter
                            width: 24
                            height: 24
                            iconSource: modelData.icon
                        }
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: modelData.label
                            font.pixelSize: StyleConstants.fontSizeXs
                            color: StyleConstants.textPrimary
                        }
                    }
                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        onClicked: stackView.push("qrc:/FitnessApp/qml/pages/diet/AddFoodPage.qml", {
                            stackView: stackView,
                            presetMealType: modelData.mealType
                        })
                    }
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
                    mealTypeName: model.mealTypeName
                    onRemove: storageService.removeLogEntryAt(index)
                }
            }
        }
    }
}
