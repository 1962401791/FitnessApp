import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
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
        { iconPath: StyleConstants.onbIconActivityPath, title: qsTr("开启健康生活新旅程"), bg: StyleConstants.onb1BgPath },
        { iconPath: StyleConstants.onbIconApplePath, title: qsTr("营养建议，融入每一天"), bg: StyleConstants.onb2BgPath },
        { iconPath: StyleConstants.onbIconUsersPath, title: qsTr("一起挑战，共同成长"), bg: StyleConstants.onb3BgPath }
    ]

    function finishOnboarding() {
        if (typeof isDebugBuild === "undefined" || !isDebugBuild) {
            storageService.hasSeenOnboarding = true
        }
        stackView.replace("qrc:/FitnessApp/qml/pages/onboarding/ModeSelectPage.qml", { stackView: stackView })
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
                Label { text: qsTr("跳过"); font.pixelSize: 14; color: StyleConstants.accent }
                Image {
                    width: 20
                    height: 20
                    source: StyleConstants.iconChevronRightAccentPath
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: finishOnboarding()
            }
        }

        Item {
            id: card
            anchors.bottom: parent.bottom
            width: parent.width
            height: 320
            property int cardRadius: 28
            property color cardTint: "#896CFE" // Base color without unnecessary alpha in definition if using Opacity elsewhere, but format #AARRGGBB is fine too. Using 50% of 896CFE.

            // Use Shape to draw top-rounded, bottom-square background with single transparency
            Shape {
                id: shapeBg
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 4 // Antialiasing

                ShapePath {
                    strokeWidth: 0
                    strokeColor: "transparent"
                    fillColor: "#80896CFE" // 50% opacity

                    startX: 0; startY: card.cardRadius
                    // Left-top corner
                    PathArc {
                        x: card.cardRadius
                        y: 0
                        radiusX: card.cardRadius; radiusY: card.cardRadius
                        useLargeArc: false
                    }
                    // Top edge
                    PathLine { x: card.width - card.cardRadius; y: 0 }
                    // Right-top corner
                    PathArc {
                        x: card.width
                        y: card.cardRadius
                        radiusX: card.cardRadius; radiusY: card.cardRadius
                        useLargeArc: false
                    }
                    // Right edge
                    PathLine { x: card.width; y: card.height }
                     // Bottom edge
                    PathLine { x: 0; y: card.height }
                     // Left edge back to start
                    PathLine { x: 0; y: card.cardRadius }
                }
            }

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
                    color: StyleConstants.textPrimary
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
                            color: index === swipeView.currentIndex ? StyleConstants.textPrimary : "rgba(255,255,255,0.4)"
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
                        text: swipeView.currentIndex === root.slides.length - 1
                            ? qsTr("开始使用")
                            : qsTr("下一页")
                        font.pixelSize: 16
                        font.bold: true
                        color: StyleConstants.textPrimary
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
