import QtQuick
import QtQuick.Controls
import FitnessApp 1.0

Rectangle {
    id: root
    property string label: ""
    property real value: 0
    property real goal: 100
    property color barColor: StyleConstants.primary
    implicitHeight: 40
    color: StyleConstants.cardBackground
    radius: StyleConstants.radiusSmall
    border.width: 1
    border.color: StyleConstants.divider

    Row {
        anchors.fill: parent
        anchors.margins: StyleConstants.spacingSmall
        spacing: StyleConstants.spacingMedium
        Label {
            width: 60
            text: root.label
            font.pixelSize: StyleConstants.fontSizeBody
            anchors.verticalCenter: parent.verticalCenter
        }
        Label {
            text: root.value.toFixed(0) + " / " + root.goal.toFixed(0) + " g"
            font.pixelSize: StyleConstants.fontSizeSmall
            anchors.verticalCenter: parent.verticalCenter
        }
        Item { width: 8; height: 1 }
        Rectangle {
            width: Math.max(0, Math.min(120, (root.goal > 0 ? root.value / root.goal : 0) * 120))
            height: 18
            radius: 4
            color: root.barColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
