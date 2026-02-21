import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("添加食物")
    property Item stackView
    property int presetMealType: 0  // 0=breakfast, 1=lunch, 2=dinner, 3=snack
    background: Rectangle { color: StyleConstants.background }

    Component.onCompleted: {
        storageService.loadFoods()
        mealTimeRow.selectedIndex = Math.min(presetMealType, 3)
    }

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
                text: qsTr("添加食物")
                font.pixelSize: StyleConstants.fontSizeTitle
                Layout.fillWidth: true
            }
        }

        TextField {
            id: searchField
            placeholderText: qsTr("搜索食物...")
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
            text: qsTr("时段")
            font.pixelSize: StyleConstants.fontSizeSmall
            color: StyleConstants.textMuted
        }
        Row {
            id: mealTimeRow
            spacing: StyleConstants.spacingSmall
            property int selectedIndex: 0
            Repeater {
                model: [qsTr("早餐"), qsTr("中餐"), qsTr("晚餐"), qsTr("加餐")]
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
            Label { text: qsTr("份量 (g)"); Layout.preferredWidth: 70 }
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
                            text: qsTr("P%1 C%2 F%3")
                                .arg(model.proteinPer100g)
                                .arg(model.carbsPer100g)
                                .arg(model.fatPer100g)
                            font.pixelSize: StyleConstants.fontSizeXs
                            color: StyleConstants.textMuted
                        }
                    }
                    background: Rectangle {
                        color: parent.pressed ? StyleConstants.primaryPale : "transparent"
                        radius: StyleConstants.radiusSmall
                    }
                    onClicked: {
                        if (storageService.addLogEntry(model.foodId, amountSpin.value, mealTimeRow.selectedIndex))
                            stackView.pop()
                    }
                }
            }
        }

        Button {
            text: qsTr("返回")
            Layout.fillWidth: true
            onClicked: stackView.pop()
        }
    }
}
