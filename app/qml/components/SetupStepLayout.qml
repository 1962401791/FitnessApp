import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Shared layout for Setup flow steps: progress bar, header (back + title), content, primary button.
 * Aligns with HSport.pen 4-A to 4.7 structure.
 */
Item {
    id: root

    property string stepTitle: ""
    property string stepSubtitle: ""
    property bool showBackButton: true
    property string buttonText: "Continue"
    property int progressStep: 0
    property int progressTotal: 4
    property bool canProceed: true

    signal backClicked()
    signal primaryClicked()

    default property alias stepContent: contentArea.data

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: StyleConstants.accent
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 12
                Item {
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    visible: root.showBackButton
                    Text {
                        text: "\u2190"
                        font.pixelSize: 24
                        color: StyleConstants.textPrimary
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.backClicked()
                    }
                }
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4
                    Label {
                        text: root.stepTitle
                        font.pixelSize: 22
                        font.bold: true
                        color: StyleConstants.textPrimary
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                    Label {
                        text: root.stepSubtitle
                        font.pixelSize: 14
                        color: StyleConstants.textMuted
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                }
            }
        }

        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 16
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            Layout.topMargin: 16
            radius: 26
            color: root.canProceed ? StyleConstants.primary : StyleConstants.surfaceGray
            Label {
                anchors.centerIn: parent
                text: root.buttonText
                font.pixelSize: 16
                font.bold: true
                color: StyleConstants.textOnPrimary
            }
            MouseArea {
                anchors.fill: parent
                enabled: root.canProceed
                onClicked: root.primaryClicked()
            }
        }
    }
}
