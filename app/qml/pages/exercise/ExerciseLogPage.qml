import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("运动记录")
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
                text: qsTr("运动记录")
                font.pixelSize: StyleConstants.fontSizeTitle
                Layout.fillWidth: true
            }
            Button {
                text: qsTr("添加")
                flat: true
                font.bold: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/exercise/AddExercisePage.qml", { stackView: stackView })
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            radius: StyleConstants.radiusMedium
            color: StyleConstants.backgroundSecondary
            Label {
                anchors.centerIn: parent
                text: qsTr("今日运动消耗：待实现")
                font.pixelSize: StyleConstants.fontSizeBody
                color: StyleConstants.textMuted
            }
        }

        Label {
            text: qsTr("添加运动后，消耗将参与每日热量盈亏计算")
            font.pixelSize: StyleConstants.fontSizeSmall
            color: StyleConstants.textMuted
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        Item { Layout.fillHeight: true }

        Button {
            text: qsTr("添加运动")
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
            onClicked: stackView.push("qrc:/FitnessApp/qml/pages/AddExercisePage.qml", { stackView: stackView })
        }
    }
}
