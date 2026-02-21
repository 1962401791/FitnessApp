import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("设置")
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
                    icon.source: StyleConstants.iconArrowLeftPath
                    icon.width: 24
                    icon.height: 24
                    display: AbstractButton.IconOnly
                    flat: true
                    onClicked: stackView.pop()
                }
                Label {
                    text: qsTr("设置")
                    font.pixelSize: StyleConstants.fontSizeTitle
                    Layout.fillWidth: true
                }
            }

            Label {
                text: qsTr("每日目标 (g)")
                font.pixelSize: StyleConstants.fontSizeBody
                font.bold: true
                color: StyleConstants.textPrimary
            }

            RowLayout {
                Layout.fillWidth: true
                Label { text: qsTr("蛋白质"); Layout.preferredWidth: 70 }
                SpinBox {
                    from: 0
                    to: 500
                    value: storageService.goalProteinG
                    onValueModified: storageService.goalProteinG = value
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: StyleConstants.inputHeight
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Label { text: qsTr("碳水"); Layout.preferredWidth: 70 }
                SpinBox {
                    from: 0
                    to: 600
                    value: storageService.goalCarbsG
                    onValueModified: storageService.goalCarbsG = value
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: StyleConstants.inputHeight
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Label { text: qsTr("脂肪"); Layout.preferredWidth: 70 }
                SpinBox {
                    from: 0
                    to: 300
                    value: storageService.goalFatG
                    onValueModified: storageService.goalFatG = value
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: StyleConstants.inputHeight
                }
            }

            Label {
                text: qsTr("基础信息")
                font.pixelSize: StyleConstants.fontSizeBody
                font.bold: true
                color: StyleConstants.textPrimary
                Layout.topMargin: StyleConstants.spacingMedium
            }

            Label {
                text: qsTr("年龄 %1  身高 %2 cm  体重 %3 kg")
                    .arg(storageService.userAge)
                    .arg(storageService.userHeightCm)
                    .arg(storageService.userWeightKg)
                font.pixelSize: StyleConstants.fontSizeSmall
                color: StyleConstants.textMuted
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("修改基础信息")
                Layout.fillWidth: true
                flat: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/main/BasicInfoPage.qml", { stackView: stackView, isEditMode: true })
            }

            Button {
                text: qsTr("返回")
                Layout.fillWidth: true
                onClicked: stackView.pop()
                Layout.topMargin: StyleConstants.spacingMedium
            }
        }
    }
}
