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
    property string buttonText: qsTr("Continue")
    property int progressStep: 0
    property int progressTotal: 4
    property bool canProceed: true

    signal backClicked()
    signal primaryClicked()

    default property alias stepContent: contentArea.data

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            
            Item {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 16
                anchors.leftMargin: 16
                width: 40
                height: 40
                visible: root.showBackButton
                
                Rectangle {
                    anchors.centerIn: parent
                    width: 40
                    height: 40
                    radius: 20
                    color: "transparent"
                    border.width: 0
                    
                    Text {
                        text: "\u2190"
                        font.pixelSize: 24
                        color: StyleConstants.textPrimary
                        anchors.centerIn: parent
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.backClicked()
                }
            }
        }
        
        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 32
            Layout.rightMargin: 32
            spacing: 8
            
            Label {
                text: root.stepTitle
                font.pixelSize: 20
                font.bold: true
                color: StyleConstants.textPrimary
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
            }
            Label {
                text: root.stepSubtitle
                font.pixelSize: 12
                color: StyleConstants.textMuted
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                visible: root.stepSubtitle !== ""
                horizontalAlignment: Text.AlignLeft
            }
        }

        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 32
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            Layout.topMargin: 24
            Layout.leftMargin: 32
            Layout.rightMargin: 32
            Layout.bottomMargin: 32
            radius: 28
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
