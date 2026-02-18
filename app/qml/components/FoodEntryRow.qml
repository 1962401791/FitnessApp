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
            text: root.foodName + " " + root.amountG.toFixed(0) + "g"
            font.pixelSize: StyleConstants.fontSizeBody
            elide: Text.ElideRight
            color: StyleConstants.textPrimary
        }
        Label {
            text: "P" + root.proteinG.toFixed(0) + " C" + root.carbsG.toFixed(0) + " F" + root.fatG.toFixed(0)
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
