import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

Rectangle {
    id: root
    implicitHeight: row.implicitHeight + StyleConstants.spacingMedium
    property string foodName: ""
    property real amountG: 0
    property real proteinG: 0
    property real carbsG: 0
    property real fatG: 0
    property real kcal: 0
    signal remove()

    color: "transparent"
    radius: StyleConstants.radiusSmall

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: StyleConstants.spacingMedium
        Label {
            Layout.fillWidth: true
            text: qsTr("%1 %2g").arg(root.foodName).arg(root.amountG.toFixed(0))
            font.pixelSize: StyleConstants.fontSizeBody
            elide: Text.ElideRight
            color: StyleConstants.textPrimary
        }
        Label {
            text: qsTr("P%1 C%2 F%3")
                .arg(root.proteinG.toFixed(0))
                .arg(root.carbsG.toFixed(0))
                .arg(root.fatG.toFixed(0))
            font.pixelSize: StyleConstants.fontSizeXs
            color: StyleConstants.textMuted
        }
        Button {
            text: "×"
            flat: true
            font.pixelSize: StyleConstants.fontSizeTitle
            onClicked: root.remove()
        }
    }
}
