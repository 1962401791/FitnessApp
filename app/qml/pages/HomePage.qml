import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Page {
    id: root
    title: qsTr("首页")
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingLarge
        spacing: StyleConstants.spacingMedium

        Row {
            Layout.fillWidth: true
            spacing: StyleConstants.spacingMedium
            Image {
                width: 40
                height: 40
                source: StyleConstants.logoPath
                fillMode: Image.PreserveAspectFit
            }
            Label {
                text: qsTr("今日概览")
                font.pixelSize: StyleConstants.fontSizeHeader
                font.bold: true
                color: StyleConstants.textPrimary
                anchors.verticalCenter: parent.verticalCenter
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
                    text: storageService.dailyLogModel.totalKcal.toFixed(0) + " kcal"
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

        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: StyleConstants.spacingSmall
            columnSpacing: StyleConstants.spacingSmall

            CardButton {
                title: qsTr("饮食记录")
                subtitle: qsTr("记录三餐与加餐")
                icon: "📋"
                Layout.fillWidth: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/DietLogPage.qml", { stackView: stackView })
            }
            CardButton {
                title: qsTr("运动记录")
                subtitle: qsTr("添加运动消耗")
                icon: "🏃"
                Layout.fillWidth: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/ExerciseLogPage.qml", { stackView: stackView })
            }
            CardButton {
                title: qsTr("每日总结")
                subtitle: qsTr("摄入与目标对比")
                icon: "📊"
                Layout.fillWidth: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/DailySummaryPage.qml", { stackView: stackView })
            }
            CardButton {
                title: qsTr("设置")
                subtitle: qsTr("目标与基础信息")
                icon: "⚙"
                Layout.fillWidth: true
                onClicked: stackView.push("qrc:/FitnessApp/qml/pages/SettingsPage.qml", { stackView: stackView })
            }
        }
    }
}
