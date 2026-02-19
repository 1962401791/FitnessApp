import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Mode select: Guest (4-step Setup flow) or Login (8-step Setup, Beta).
 * Guest: SetupFlowPage with isGuestMode=true. If hasBasicInfo, skip to HomePage.
 * Login (when enabled): SetupFlowPage with isGuestMode=false. If hasBasicInfo, dialog to reuse guest data and startStep=4.
 */
Page {
    id: root
    property Item stackView
    background: Rectangle { color: StyleConstants.background }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 320)
        spacing: StyleConstants.spacingLarge

        Image {
            id: logoImage
            Layout.alignment: Qt.AlignHCenter
            source: StyleConstants.logoPath
            sourceSize.width: 120
            sourceSize.height: 120
            width: 120
            height: 120
            fillMode: Image.PreserveAspectFit
        }

        Label {
            text: qsTr("HSport")
            font.pixelSize: StyleConstants.fontSizeDisplay
            font.bold: true
            color: StyleConstants.textPrimary
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("选择使用模式")
            font.pixelSize: StyleConstants.fontSizeBody
            color: StyleConstants.textMuted
            Layout.alignment: Qt.AlignHCenter
        }

        Item { height: StyleConstants.spacingLarge }

        Button {
            id: guestBtn
            text: qsTr("游客模式")
            Layout.fillWidth: true
            Layout.preferredHeight: StyleConstants.buttonHeight
            font.pixelSize: StyleConstants.fontSizeBody
            contentItem: Text {
                text: guestBtn.text
                font: guestBtn.font
                color: StyleConstants.textOnPrimary
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                radius: StyleConstants.radiusXLarge
                color: guestBtn.pressed ? StyleConstants.primaryLight : StyleConstants.primary
            }
            onClicked: {
                if (storageService.hasBasicInfo && 0) {
                    stackView.replace("qrc:/FitnessApp/qml/pages/HomePage.qml", { stackView: stackView })
                } else {
                    stackView.push("qrc:/FitnessApp/qml/pages/SetupFlowPage.qml", {
                        stackView: stackView,
                        isGuestMode: true
                    })
                }
            }
        }

        Button {
            id: loginBtn
            text: qsTr("登录模式")
            Layout.fillWidth: true
            Layout.preferredHeight: StyleConstants.buttonHeight
            font.pixelSize: StyleConstants.fontSizeBody
            enabled: false
            opacity: 0.5
            contentItem: Text {
                text: loginBtn.text
                font: loginBtn.font
                color: StyleConstants.textOnPrimary
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                radius: StyleConstants.radiusXLarge
                color: StyleConstants.surfaceGray
            }
        }

        Label {
            text: qsTr("Beta 版本暂未开放")
            font.pixelSize: StyleConstants.fontSizeXs
            color: StyleConstants.textMuted
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
