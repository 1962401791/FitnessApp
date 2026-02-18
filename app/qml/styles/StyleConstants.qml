pragma Singleton
import QtQuick

/**
 * Design tokens aligned with Figma Fitness App UI Kit
 * https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/
 */
QtObject {
    id: root

    readonly property color primary: "#896CFE"
    readonly property color primaryLight: "#B3A0FF"
    readonly property color primaryPale: "#C6B8FF"
    readonly property color cardOverlay: "#896CFEF2"  // ~95% opacity for consistent overlay across onboarding backgrounds
    readonly property color accent: "#E2F163"
    readonly property color accentLime: "#E2F163"

    readonly property color background: "#000000"
    readonly property color backgroundSecondary: "#121212"
    readonly property color cardBackground: "#1A1A1A"
    readonly property color surfaceGray: "#2D2D2D"

    readonly property color textPrimary: "#FFFFFF"
    readonly property color textSecondary: "#E5E5E5"
    readonly property color textOnPrimary: "#FFFFFF"
    readonly property color textMuted: "#9CA3AF"

    readonly property color disabled: "#444444"
    readonly property color divider: "#2D2D2D"

    readonly property real radiusSmall: 8
    readonly property real radiusMedium: 16
    readonly property real radiusLarge: 24
    readonly property real radiusXLarge: 26

    readonly property real spacingXs: 4
    readonly property real spacingSmall: 8
    readonly property real spacingMedium: 16
    readonly property real spacingLarge: 24

    readonly property int fontSizeXs: 12
    readonly property int fontSizeSmall: 13
    readonly property int fontSizeBody: 14
    readonly property int fontSizeTitle: 16
    readonly property int fontSizeHeader: 20
    readonly property int fontSizeDisplay: 24

    readonly property string fontFamily: "Segoe UI"
    readonly property string fontFamilyFallback: "sans-serif"

    readonly property real buttonHeight: 48
    readonly property real inputHeight: 48
    readonly property real navBarHeight: 56

    readonly property string logoPath: "qrc:/FitnessApp/resources/images/logo.svg"
    readonly property string logoPathPng: "qrc:/FitnessApp/resources/images/logo.png"
    readonly property string launchBgPath: "qrc:/FitnessApp/resources/images/onboarding/launch_bg.png"
    readonly property string onb1BgPath: "qrc:/FitnessApp/resources/images/onboarding/onb1_bg.png"
    readonly property string onb2BgPath: "qrc:/FitnessApp/resources/images/onboarding/onb2_bg.png"
    readonly property string onb3BgPath: "qrc:/FitnessApp/resources/images/onboarding/onb3_bg.png"
    readonly property string onbIconActivityPath: "qrc:/FitnessApp/resources/images/onboarding/icon_activity.svg"
    readonly property string onbIconApplePath: "qrc:/FitnessApp/resources/images/onboarding/icon_apple.svg"
    readonly property string onbIconUsersPath: "qrc:/FitnessApp/resources/images/onboarding/icon_users.svg"
    readonly property string setupIconMalePath: "qrc:/FitnessApp/resources/images/onboarding/icon_male.svg"
    readonly property string setupIconFemalePath: "qrc:/FitnessApp/resources/images/onboarding/icon_female.svg"

    readonly property color primaryColor: primary
    readonly property color secondaryColor: surfaceGray
    readonly property int fontPixelSizeHeader: fontSizeHeader
}
