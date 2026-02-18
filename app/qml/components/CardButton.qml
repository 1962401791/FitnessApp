import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Rectangle {
    id: root
    signal clicked()
    property string title: ""
    property string subtitle: ""
    property string icon: ""
    implicitHeight: 90
    radius: StyleConstants.radiusLarge
    color: mouse.pressed ? StyleConstants.primaryPale : StyleConstants.cardBackground
    border.width: 1
    border.color: StyleConstants.divider

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingMedium
        spacing: StyleConstants.spacingXs
        Item {
            width: 32
            height: 32
            Layout.alignment: Qt.AlignLeft
            Label {
                text: root.icon
                font.pixelSize: 24
                anchors.centerIn: parent
            }
        }
        Label {
            text: root.title
            font.pixelSize: StyleConstants.fontSizeBody
            font.bold: true
            color: StyleConstants.textPrimary
            Layout.fillWidth: true
        }
        Label {
            text: root.subtitle
            font.pixelSize: StyleConstants.fontSizeXs
            color: StyleConstants.textMuted
            Layout.fillWidth: true
        }
    }
}
