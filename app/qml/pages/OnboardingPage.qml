import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FitnessApp 1.0

/**
 * Onboarding: 1:1 with HSport.pen 2-A/B/C.
 * Full-bleed bg images (onb1/2/3_bg.png), bottom card (cardOverlay), icon, title, dots, button.
 * Card: padding 32, gap 20; top corners radius 24; height 320.
 */
Page {
    id: root
    property Item stackView
    background: Rectangle { color: "#0F0F1A" }

    readonly property var slides: [
        { iconPath: StyleConstants.onbIconActivityPath, title: "开启健康生活新旅程", bg: StyleConstants.onb1BgPath },
        { iconPath: StyleConstants.onbIconApplePath, title: "营养建议，融入每一天", bg: StyleConstants.onb2BgPath },
        { iconPath: StyleConstants.onbIconUsersPath, title: "一起挑战，共同成长", bg: StyleConstants.onb3BgPath }
    ]

    function finishOnboarding() {
        if (typeof isDebugBuild === "undefined" || !isDebugBuild) {
            storageService.hasSeenOnboarding = true
        }
        stackView.replace("qrc:/FitnessApp/qml/pages/ModeSelectPage.qml", { stackView: stackView })
    }

    Item {
        anchors.fill: parent

        SwipeView {
            id: swipeView
            anchors.fill: parent
            interactive: true
            clip: true

            Repeater {
                model: root.slides
                Item {
                    width: swipeView.width
                    height: swipeView.height
                    Rectangle {
                        anchors.fill: parent
                        visible: bgImg.status !== Image.Ready
                        gradient: Gradient {
                            orientation: Gradient.Vertical
                            GradientStop { position: 0.0; color: "#1A1A2E" }
                            GradientStop { position: 0.5; color: "#16213E" }
                            GradientStop { position: 1.0; color: "#0F0F1A" }
                        }
                    }
                    Image {
                        id: bgImg
                        anchors.fill: parent
                        source: modelData.bg
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
        }

        Item {
            anchors.top: parent.top
            anchors.right: parent.right
            width: 80
            height: 56
            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 16
                spacing: 6
                Label { text: "跳过"; font.pixelSize: 14; color: StyleConstants.accent }
                Text { text: "→"; font.pixelSize: 18; color: StyleConstants.accent }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: finishOnboarding()
            }
        }

        Rectangle {
            id: card
            anchors.bottom: parent.bottom
            width: parent.width
            height: 320
            radius: 24
            color: StyleConstants.cardOverlay

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 32
                spacing: 20

                Item {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 56
                    Layout.preferredHeight: 56
                    Image {
                        anchors.centerIn: parent
                        width: 56
                        height: 56
                        source: root.slides[swipeView.currentIndex] ? root.slides[swipeView.currentIndex].iconPath : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Label {
                    Layout.preferredWidth: 320
                    Layout.alignment: Qt.AlignHCenter
                    text: root.slides[swipeView.currentIndex] ? root.slides[swipeView.currentIndex].title : ""
                    font.pixelSize: 22
                    font.bold: true
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                Row {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 8
                    Repeater {
                        model: root.slides.length
                        Rectangle {
                            width: index === swipeView.currentIndex ? 24 : 8
                            height: 8
                            radius: 4
                            color: index === swipeView.currentIndex ? "#FFFFFF" : "rgba(255,255,255,0.4)"
                            Behavior on width { NumberAnimation { duration: 150 } }
                        }
                    }
                }

                Item { Layout.fillHeight: true }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    Layout.leftMargin: 0
                    Layout.rightMargin: 0
                    radius: 26
                    color: swipeView.currentIndex === root.slides.length - 1
                        ? StyleConstants.primary
                        : "#4A4A4A"
                    Label {
                        anchors.centerIn: parent
                        text: swipeView.currentIndex === root.slides.length - 1 ? "开始使用" : "下一页"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#FFFFFF"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (swipeView.currentIndex === root.slides.length - 1)
                                finishOnboarding()
                            else
                                swipeView.incrementCurrentIndex()
                        }
                    }
                }
            }
        }
    }
}
