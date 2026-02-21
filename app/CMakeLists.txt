cmake_minimum_required(VERSION 3.16)
project(FitnessApp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick QuickControls2 Sql Svg LinguistTools)
qt_standard_project_setup(REQUIRES 6.5)
qt_policy(SET QTP0004 NEW)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

qt_add_executable(FitnessApp
    src/main.cpp
    src/core/NutritionCalculator.cpp
    src/models/FoodItem.cpp
    src/models/DailyLogEntry.cpp
    src/models/FoodListModel.cpp
    src/models/DailyLogModel.cpp
    src/services/IPoseCorrectionService.cpp
    src/services/StorageService.cpp
    src/services/PoseCorrectionService.cpp
)

target_include_directories(FitnessApp PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/models
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core
    ${CMAKE_CURRENT_SOURCE_DIR}/src/services
)
# Qt-generated qmltyperegistrations.cpp uses #include <DailyLogEntry.h> etc.; ensure that target can find headers
# Target name may be FitnessApp_qmltyperegistrations or fitnessapp_qmltyperegistrations depending on generator
foreach(_qml_reg_target FitnessApp_qmltyperegistrations fitnessapp_qmltyperegistrations)
    if(TARGET ${_qml_reg_target})
        target_include_directories(${_qml_reg_target} PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/src/models
            ${CMAKE_CURRENT_SOURCE_DIR}/src/core
            ${CMAKE_CURRENT_SOURCE_DIR}/src/services
        )
        target_link_libraries(${_qml_reg_target} PRIVATE Qt6::Core)
        break()
    endif()
endforeach()

# Singleton QML type: must be set before qt_add_qml_module (see Qt doc Singletons)
set_source_files_properties(qml/styles/StyleConstants.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

# RESOURCE_PREFIX "/" so QML is at qrc:/FitnessApp/qml/... (main.cpp); required when using qt_standard_project_setup(REQUIRES 6.5)
qt_add_qml_module(FitnessApp
    URI FitnessApp
    VERSION 1.0
    RESOURCE_PREFIX "/"
    RESOURCES
        resources/images/logo.png
        resources/images/logo.svg
        resources/images/onboarding/launch_bg.png
        resources/images/onboarding/onb1_bg.png
        resources/images/onboarding/onb2_bg.png
        resources/images/onboarding/onb3_bg.png
        resources/images/onboarding/icon_activity.svg
        resources/images/onboarding/icon_apple.svg
        resources/images/onboarding/icon_users.svg
        resources/images/onboarding/icon_male.svg
        resources/images/onboarding/icon_female.svg
        resources/images/icons/icon_arrow_left.svg
        resources/images/icons/icon_chevron_right.svg
        resources/images/icons/icon_chevron_right_accent.svg
        resources/images/icons/icon_diet.svg
        resources/images/icons/icon_exercise.svg
        resources/images/icons/icon_chart.svg
        resources/images/icons/icon_settings.svg
        resources/images/icons/icon_protein.svg
        resources/images/icons/icon_carbs.svg
        resources/images/icons/icon_fat.svg
        resources/images/icons/icon_calorie.svg
        resources/images/icons/icon_breakfast.svg
        resources/images/icons/icon_lunch.svg
        resources/images/icons/icon_dinner.svg
        resources/images/icons/icon_snack.svg
    QML_FILES
        qml/main.qml
        qml/styles/StyleConstants.qml
        qml/pages/onboarding/LaunchPage.qml
        qml/pages/onboarding/OnboardingPage.qml
        qml/pages/onboarding/ModeSelectPage.qml
        qml/pages/main/BasicInfoPage.qml
        qml/pages/setup/SetupFlowPage.qml
        qml/pages/setup/SetupIntroPage.qml
        qml/pages/setup/SetupGenderPage.qml
        qml/pages/setup/SetupAgePage.qml
        qml/pages/setup/SetupWeightPage.qml
        qml/pages/setup/SetupHeightPage.qml
        qml/pages/setup/SetupGoalPage.qml
        qml/pages/setup/SetupActivityPage.qml
        qml/pages/setup/SetupProfilePage.qml
        qml/pages/main/HomePage.qml
        qml/pages/diet/DietLogPage.qml
        qml/pages/diet/AddFoodPage.qml
        qml/pages/main/DailySummaryPage.qml
        qml/pages/exercise/ExerciseLogPage.qml
        qml/pages/exercise/AddExercisePage.qml
        qml/pages/main/SettingsPage.qml
        qml/components/Icon.qml
        qml/components/NutrientBar.qml
        qml/components/SetupStepLayout.qml
        qml/components/FoodEntryRow.qml
        qml/components/CardButton.qml
        qml/components/MacroSummary.qml
        qml/components/MacroSummaryCard.qml
)

qt_add_translations(FitnessApp
    TS_FILES
        i18n/hsport_en.ts
        i18n/hsport_zh_CN.ts
    QM_FILES_OUTPUT_VARIABLE qm_files
)

foreach(qm_file IN LISTS qm_files)
    get_filename_component(qm_name "${qm_file}" NAME)
    set_source_files_properties("${qm_file}" PROPERTIES QT_RESOURCE_ALIAS "${qm_name}")
endforeach()

qt_add_resources(FitnessApp "i18n"
    PREFIX "/i18n"
    FILES ${qm_files}
)

target_link_libraries(FitnessApp PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Sql
    Qt6::Svg
)

# Android: app name, icon, and package source
if(ANDROID)
    set_target_properties(FitnessApp PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
        QT_ANDROID_APP_NAME "HSport"
        QT_ANDROID_APP_ICON "@mipmap/ic_launcher"
    )
endif()
