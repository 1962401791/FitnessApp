import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: "添加运动"
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingLarge
        spacing: StyleConstants.spacingMedium

        Label {
            text: "运动类型与时长"
            font.pixelSize: StyleConstants.fontSizeTitle
            color: StyleConstants.textPrimary
        }

        ComboBox {
            id: typeCombo
            model: ["跑步", "步行", "骑行", "游泳", "力量训练", "其他"]
            Layout.fillWidth: true
            Layout.preferredHeight: StyleConstants.inputHeight
        }

        RowLayout {
            Layout.fillWidth: true
            Label { text: "时长 (分钟)"; Layout.preferredWidth: 90 }
            SpinBox {
                id: durationSpin
                from: 1
                to: 300
                value: 30
                editable: true
                Layout.fillWidth: true
                Layout.preferredHeight: StyleConstants.inputHeight
            }
        }

        Item { Layout.fillHeight: true }

        Button {
            text: "保存"
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
            onClicked: stackView.pop()
        }
    }
}
