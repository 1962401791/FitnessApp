import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Basic info for BMR: age (required), height (required), weight, gender.
 */
Page {
    id: root
    title: "基础信息"
    property Item stackView
    property bool isEditMode: false
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingLarge
        spacing: StyleConstants.spacingMedium

        Label {
            text: "完善基础信息"
            font.pixelSize: StyleConstants.fontSizeHeader
            font.bold: true
            color: StyleConstants.textPrimary
        }
        Label {
            text: "用于计算基础代谢率（BMR）及运动消耗"
            font.pixelSize: StyleConstants.fontSizeSmall
            color: StyleConstants.textMuted
        }

        Item { height: StyleConstants.spacingMedium }

        RowLayout {
            Layout.fillWidth: true
            Label { text: "年龄 (岁) *"; Layout.preferredWidth: 90 }
            SpinBox {
                id: ageSpin
                from: 10
                to: 120
                value: storageService.userAge || 25
                editable: true
                Layout.fillWidth: true
                Layout.preferredHeight: StyleConstants.inputHeight
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Label { text: "身高 (cm) *"; Layout.preferredWidth: 90 }
            SpinBox {
                id: heightSpin
                from: 100
                to: 250
                value: storageService.userHeightCm || 170
                editable: true
                Layout.fillWidth: true
                Layout.preferredHeight: StyleConstants.inputHeight
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Label { text: "体重 (kg)"; Layout.preferredWidth: 90 }
            SpinBox {
                id: weightSpin
                from: 30
                to: 200
                value: storageService.userWeightKg || 65
                editable: true
                Layout.fillWidth: true
                Layout.preferredHeight: StyleConstants.inputHeight
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Label { text: "性别"; Layout.preferredWidth: 90 }
            Row {
                spacing: StyleConstants.spacingSmall
                Button {
                    text: "男"
                    checked: storageService.userIsMale
                    checkable: true
                    onClicked: storageService.userIsMale = true
                    background: Rectangle {
                        radius: StyleConstants.radiusSmall
                        color: parent.checked ? StyleConstants.primary : StyleConstants.surfaceGray
                    }
                }
                Button {
                    text: "女"
                    checked: !storageService.userIsMale
                    checkable: true
                    onClicked: storageService.userIsMale = false
                    background: Rectangle {
                        radius: StyleConstants.radiusSmall
                        color: parent.checked ? StyleConstants.primary : StyleConstants.surfaceGray
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Button {
            text: "开始使用"
            Layout.fillWidth: true
            Layout.preferredHeight: StyleConstants.buttonHeight
            font.pixelSize: StyleConstants.fontSizeBody
            contentItem: Text {
                text: parent.text
                font: parent.font
                color: StyleConstants.textOnPrimary
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                radius: StyleConstants.radiusXLarge
                color: parent.pressed ? StyleConstants.primaryLight : StyleConstants.primary
            }
            onClicked: {
                storageService.userAge = ageSpin.value
                storageService.userHeightCm = heightSpin.value
                storageService.userWeightKg = weightSpin.value
                if (isEditMode)
                    stackView.pop()
                else
                    stackView.replace("qrc:/FitnessApp/qml/pages/HomePage.qml", { stackView: stackView })
            }
        }
    }
}
