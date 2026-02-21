# Daily Progress Log

## 2026-02-19

- **HSport.pen 按操作逻辑链分组展示**：在画布中新增 5 个 Note 引导标签（1. 入口 Launch / 2. Onboarding 引导 / 4. Set Up 设置 / 5. 主应用 Tab / 子页面）；将各帧重新排布为纵向分组，便于按流程浏览；docs/hsport-pen-ui-logic-map.md 更新流程说明。

- **Diet 与 Health 页面去重**：
  - 6-Diet 与 8-Health 展示重合：二者均展示今日摄入 kcal 与三大营养素。
  - 8-Health 重新定位为「健康与规划」：移除健康 Summary 紫色卡、三大营养素进度条、「查看每日总结」按钮。
  - 替换为：本周快览（运动天数、目标完成）、规划入口（训练计划、健康报告）、趋势与建议占位。
  - 6-Diet 保留为饮食单一真相源；8-Health 与其互补不重复。
  - docs/hsport-pen-ui-logic-map.md 新增 3.3 底部导航 Tab 页映射及职责说明。

- **HSport.pen 6-Diet 页重新设计**：
  - **三大营养素摄入阈值**：蛋白/碳水/脂肪/kcal 每张卡片增加进度条 + 当前/目标值（如 45/80g）+ 级别文案（减脂|正常|增加）。
  - **饮食统计图表化**：新增「今日营养构成」环形图（P/C/F 比例）+ 图例；「餐次热量分布」横向条形图（早/中/晚/加餐 kcal）；保留「今日记录」紧凑列表。
  - **食物添加页 AddFood-早餐**：参考薄荷布局——顶部日期+餐次、搜索框、快捷按钮（复制记录/快速记录/扫条形码）；左侧分类导航（常见/自定义/已购/主食/蔬果/肉蛋奶）；右侧食物列表（缩略图+名称+千卡+加号按钮）；底部栏（早餐标识+完成按钮）；沿用 $backgroundDark、$primary、$surfaceGray 等设计系统变量。

- **饮食页按时段入口重构**：移除顶部「添加」按钮；在 MacroSummary 下方新增 4 个时段入口（早餐/中餐/晚餐/加餐）；数据层新增 meal_type（0–3），daily_log 表迁移；DailyLogEntry/DailyLogModel 扩展 mealType/mealTypeName；StorageService.addLogEntry(foodId, amountG, mealType)；AddFoodPage 支持 presetMealType；FoodEntryRow 显示 mealTypeName · kcal；新增 icon_breakfast/lunch/dinner/snack.svg；HSport.pen 6-Diet 同步更新。

- **饮食页三大营养素展示优化**：原「P 45 C 120 F 38 896 kcal」单行文字改为 4 张独立卡片（蛋白质/碳水/脂肪/kcal），每张带图标、数值、单位；新增 SVG 矢量图标 `icon_protein.svg`（蛋形 #896CFE）、`icon_carbs.svg`（麦穗 #E2F163）、`icon_fat.svg`（油滴 #B3A0FF）、`icon_calorie.svg`（火焰 白色）；新增 MacroSummary.qml、MacroSummaryCard.qml 组件；DietLogPage 改用 MacroSummary；HSport.pen 中 6-Diet 帧同步更新为 4 宫格布局；StyleConstants 新增 iconProteinPath 等 4 个路径；CMakeLists 注册新资源与组件。

- **Logo 重设计**：logo.svg 改为小写 h 流线体（含 s 灵动感），偏紫粉色 #B57EDC；logo.png 深色背景 #121212；Android 自适应图标：background #121212、foreground 为矢量 h；StyleConstants 新增 logoColor。

- **矢量图标系统**：新增 `resources/images/icons/` 目录，生成 arrow_left、chevron_right、diet、exercise、chart、settings 等 SVG；统一路径由 StyleConstants 管理；新增 Icon.qml 组件；CardButton 改用 iconSource；各页面 "←"→iconArrowLeftPath、"→"→iconChevronRightAccentPath，emoji→对应 icon 路径。详见 `resources/images/icons/README.md`。

- **设计风格审查与修复**：依据 `StyleConstants.qml` 与 `HSport.pen` 设计稿，完成代码与设计风格对齐。
- **报告**：新增 `docs/design-style-audit-report.md` 记录问题与修复。
- **StyleConstants 扩展**：新增 `radiusUnitToggle`、`fontSizeValueDisplay`、`fontSizeAgeDisplay`、`spacingPage`、`spacingLayout`。
- **Setup 流程**：统一背景色 (#000000→backgroundSecondary)、picker 未选中颜色 (#2D2D2D/#4B4B4B/#8B8B8B→textMuted)、主按钮圆角 (28→radiusXLarge)、硬编码颜色/字体/间距替换为 StyleConstants。
- **其他页面**：OnboardingPage、LaunchPage 的 #FFFFFF→textPrimary；CardButton 图标增加 color、fontSizeDisplay。

## 2026-02-18

- **Setup 流程 QML 实现**：游客模式仅前 4 步（4-A Intro → 4.1 Gender → 4.2 Age → 4.3 Weight），登录模式 8 步（预留 4.4–4.7），完成流程进入 HomePage。
- **StorageService 扩展**：新增 `userGoal`（0–4）、`userActivityLevel`（0–2），持久化至 settings 表；`setUserIsMale` 时触发 `hasBasicInfoChanged`。
- **Setup 页面**：SetupFlowPage 容器 + SetupIntroPage、SetupGenderPage、SetupAgePage、SetupWeightPage（游客）；SetupHeightPage、SetupGoalPage、SetupActivityPage、SetupProfilePage（登录，Beta 保留设计）。
- **SetupStepLayout 组件**：进度条、返回/标题、内容区、主按钮；各 Setup 页复用此布局。
- **性别图标**：创建 `icon_male.svg`、`icon_female.svg`；UI 使用 Unicode ♂♀ 便于状态着色。
- **ModeSelectPage**：游客且无 hasBasicInfo 时，改为推送 SetupFlowPage（替代 BasicInfoPage）；登录按钮仍禁用。
- **完成逻辑**：游客完成第 4 步后，若 userHeightCm 未填则默认 170，满足 hasBasicInfo 后进入首页。
- **文档**：更新 `docs/hsport-pen-ui-logic-map.md` 反映 Setup 实现；CMakeLists 增加新 QML 及 icon 资源。

## 2026-02-15（续 9）

- **UI 逻辑链映射**：新增 `docs/hsport-pen-ui-logic-map.md`，建立 HSport.pen 设计帧与 Figma UI 逻辑链、QML 页面的对应关系，支持设计稿与实现的双向追溯。

## 2026-02-15（续 8）

- **Onboarding 优化**：底部卡片 cardOverlay 透明度由 D9 调为 F2（约 95%），三屏下半部分颜色更一致；icon_apple.svg 增加 shape-rendering="geometricPrecision" 优化矢量渲染。

## 2026-02-15（续 7）

- **Setup 对齐 Figma**：参考 [Figma Fitness App](https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/) 优化——4-A 文案防溢出（包裹容器 + 字号 18/13）、图高 180、space_between 布局；4.5 Goal 增加 Lose Weight 选中态（主色背景 + accent 单选）；统一 gap 16、padding 20；4.6 活动选项高 52；4.7 头像居中。

## 2026-02-15（续 6）

- **Setup 页面优化**：修正黄色进度条未占满顶部的问题——进度条置于无 padding 的顶层 wrapper，宽度 390px、cornerRadius 0，铺满整屏；4-A 介绍页内容区统一 fill_container 提升协调性；4.4 身高页增加 CM/FT 单位切换（与 Figma 一致）；4.1–4.4 保持原有布局，色系沿用 HSport $primary / $accent。

## 2026-02-15（续 5）

- **Setup 页面设计**：参考 [Figma Fitness App UI Kit](https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/) Set Up 流程，在 HSport.pen 中绘制 8 屏 Setup：4-A 介绍、4.1 性别、4.2 年龄、4.3 体重、4.4 身高、4.5 目标、4.6 活动等级、4.7 完善资料；使用 HSport 主色 $primary、强调色 $accent、深色背景 #121212、进度条、返回、Continue/Start 按钮等，与现有 Launch/Onboarding 风格一致。

## 2026-02-15（续 4）

- **Logo 更新**：替换 `logo.png` 为粉色线条风格新 Logo，已复制至 `resources/images/logo.png`；LaunchPage 通过 `logoPathPng` 引用，重新构建后即可展示。

## 2026-02-15（续 3）

- **Onboarding 图标**：将 emoji 替换为 SVG 图标；新增 `icon_activity.svg`、`icon_apple.svg`、`icon_users.svg`（Lucide 风格，accent #E2F163），并在 OnboardingPage 中通过 Image 引用。

## 2026-02-15（续 2）

- **Onboarding 资源**：使用 `resources/images/onboarding/` 中的 launch_bg.png、onb1/2/3_bg.png 优化 Launch 与 Onboarding 页面，尽量 1:1 还原 HSport.pen。
- LaunchPage：全屏 launch_bg.png 背景，加载失败时使用渐变。
- OnboardingPage：每屏使用对应 onb1/2/3_bg.png 全屏背景；底部 cardOverlay 卡片、图标、标题、进度点、按钮；跳过按钮右上角。

## 2026-02-15（续）

- **调试模式**：main.cpp 暴露 `isDebugBuild`（Debug 构建为 true）；Launch 在调试模式下始终走完整流程（不跳过）；Onboarding 完成时不持久化 `hasSeenOnboarding`，下次启动仍展示。
- **UI 对齐 HSport.pen**：LaunchPage 深色渐变背景、logo.png 置于紫色圆角框、白色/强调色文案；OnboardingPage 底部 cardOverlay 卡片、图标+标题+进度点+按钮，第 3 屏「开始使用」用主色；StyleConstants 新增 cardOverlay。
- **资源说明**：`resources/images/onboarding/README.md` 说明从 HSport.pen 导出背景图的步骤。

## 2026-02-15

- **Launch + Onboarding 流程**：整体流程改为 Launch → Onboarding → 模式选择 → 基础信息 → 首页。
- LaunchPage：使用 logo.png 展示品牌；欢迎使用、HSport、健康生活 · 健身融入每一天；约 2s 自动跳转或点击跳过；若 hasSeenOnboarding 则直接进入模式选择。
- OnboardingPage：3 屏引导（开启健康生活新旅程 / 营养建议，融入每一天 / 一起挑战，共同成长）；跳过、进度点、下一页/开始使用；完成后持久化 hasSeenOnboarding。
- StorageService：新增 hasSeenOnboarding 属性，持久化至 settings 表。
- StyleConstants：新增 logoPathPng（logo.png）。
- main.qml：initialItem 改为 LaunchPage。
- todo.md：将 Launch+Onboarding 提升为 P0 优先任务；更新 MVP 验收标准。
- docs/decisions.md：更新用户流程说明。

## 2026-02-14

- UI 设计：基于 Figma Fitness App UI Kit 实现界面；更新 StyleConstants（主色 #896CFE、强调色 #E2F163 等）；新增 ModeSelectPage、BasicInfoPage、ExerciseLogPage、AddExercisePage；首页卡片式布局、CardButton 组件；StorageService 扩展 userAge/Height/Weight/IsMale、hasBasicInfo；Logo 占位（resources/images/README）。
- 文档：docs/figma-design.md 记录 Figma 对齐。

## 2026-02-13（续）

- 产品需求文档：补充模式选择、基础信息（年龄/身高必填）、运动记录、BMR 与运动消耗计算；设计流程与 UI 逻辑；更新 todo、decisions。

## 2026-02-13

- Initial project creation from plan.
- Scaffold: CMake, directory layout, README, todo, docs, log.
- Data layer: SQLite schema (foods, daily_log, settings), FoodItem/DailyLogEntry, FoodListModel/DailyLogModel, NutritionCalculator, StorageService with CRUD and goals.
- QML: StyleConstants (colors, spacing, fonts), main.qml with StackView, HomePage (nav to Diet/Summary/Settings), DietLogPage (today list + add food), AddFoodPage (search, amount, add entry), DailySummaryPage (totals + goal bars), SettingsPage (daily goals), NutrientBar, FoodEntryRow.
- C++ exposed via context property storageService and singletons NutritionCalculator, PoseCorrectionService.
- PoseCorrectionService: IPoseCorrectionService interface + stub implementation (startExercise/stopExercise/isActive); ready for later camera/ML integration.
