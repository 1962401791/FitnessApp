import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 390
    height: 680
    title: qsTr("HSport")
    color: StyleConstants.background

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: LaunchPage { stackView: stack }
    }
}
