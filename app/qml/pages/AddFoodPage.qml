import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: "添加食物"
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    Component.onCompleted: storageService.loadFoods()

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
                text: "添加食物"
                font.pixelSize: StyleConstants.fontSizeTitle
                Layout.fillWidth: true
            }
        }

        TextField {
            id: searchField
            placeholderText: "搜索食物..."
            Layout.fillWidth: true
            Layout.preferredHeight: StyleConstants.inputHeight
            background: Rectangle {
                radius: StyleConstants.radiusSmall
                border.width: 1
                border.color: StyleConstants.surfaceGray
                color: StyleConstants.background
            }
            onTextChanged: storageService.searchFoods(text)
        }

        Label {
            text: "时段"
            font.pixelSize: StyleConstants.fontSizeSmall
            color: StyleConstants.textMuted
        }
        Row {
            id: mealTimeRow
            spacing: StyleConstants.spacingSmall
            property int selectedIndex: 0
            Repeater {
                model: ["早餐", "中餐", "晚餐", "加餐"]
                Button {
                    text: modelData
                    flat: true
                    checkable: true
                    checked: index === mealTimeRow.selectedIndex
                    onClicked: mealTimeRow.selectedIndex = index
                    background: Rectangle {
                        radius: StyleConstants.radiusSmall
                        color: parent.checked ? StyleConstants.primary : StyleConstants.backgroundSecondary
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Label { text: "份量 (g)"; Layout.preferredWidth: 70 }
            SpinBox {
                id: amountSpin
                from: 1
                to: 5000
                value: 100
                editable: true
                Layout.preferredWidth: 120
                Layout.preferredHeight: StyleConstants.inputHeight
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: availableWidth
            clip: true
            ListView {
                id: foodList
                model: storageService.foodListModel
                delegate: ItemDelegate {
                    width: ListView.view.width - 20
                    height: 56
                    contentItem: RowLayout {
                        Label {
                            text: model.name
                            font.pixelSize: StyleConstants.fontSizeBody
                            Layout.fillWidth: true
                        }
                        Label {
                            text: "P" + model.proteinPer100g + " C" + model.carbsPer100g + " F" + model.fatPer100g
                            font.pixelSize: StyleConstants.fontSizeXs
                            color: StyleConstants.textMuted
                        }
                    }
                    background: Rectangle {
                        color: parent.pressed ? StyleConstants.primaryPale : "transparent"
                        radius: StyleConstants.radiusSmall
                    }
                    onClicked: {
                        if (storageService.addLogEntry(model.foodId, amountSpin.value))
                            stackView.pop()
                    }
                }
            }
        }

        Button {
            text: "返回"
            Layout.fillWidth: true
            onClicked: stackView.pop()
        }
    }
}
