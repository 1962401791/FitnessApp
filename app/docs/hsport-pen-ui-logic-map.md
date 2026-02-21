# HSport.pen UI 逻辑链映射

> 参考 [Figma Fitness App UI Kit](https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/Fitness-App-UI-Kit-for-Gym-Workout-App-Fitness-Tracker-Mobile-App-Gym-Fitness-Mobile-App-UI-Kit--Community-?node-id=1-421&m=dev&t=VnkyTJUBKZHpGuXk-1) 的 UI 逻辑链，建立 HSport.pen 设计稿与流程的对应关系。

---

## 1. 入口与引导链路

| UI 逻辑步骤 | HSport.pen 帧名 | 帧 ID | QML 实现 | 说明 |
|-------------|-----------------|-------|----------|------|
| **1. Launch** | 1-Launch | 2lVQN | LaunchPage.qml | 启动页：logo、欢迎使用、品牌标语 |
| **2. Onboarding** | 2-A-Onboarding | G9dKu | OnboardingPage.qml (slide 0) | 开启健康生活新旅程 |
| | 2-B-Onboarding | piO0s | OnboardingPage.qml (slide 1) | 营养建议，融入每一天 |
| | 2-C-Onboarding | z4vxf | OnboardingPage.qml (slide 2) | 一起挑战，共同成长 |
| **3. Login/Sign-Up** | （未设计） | — | ModeSelectPage.qml | 游客/登录模式选择，Beta 登录置灰 |
| **4. Set Up** | 4-A-Set Up (Intro) | tVtzf | SetupIntroPage.qml | 介绍屏：健身图、标语、Next |
| | 4.1-A-Gender | jURlb | SetupGenderPage.qml | 性别选择（游客+登录） |
| | 4.2-A-How old are you | PA82D | SetupAgePage.qml | 年龄（游客+登录） |
| | 4.3-A-Weight | 26Dtt | SetupWeightPage.qml | 体重 + KG/LB（游客+登录） |
| | 4.4-A-Height | pihoH | SetupHeightPage.qml | 身高 + CM/FT（仅登录） |
| | 4.5-A-Goal | iWidq | SetupGoalPage.qml | 目标：减脂/增肌/塑形等（仅登录） |
| | 4.6-A-Physical activity level | 7NteU | SetupActivityPage.qml | 活动等级（仅登录） |
| | 4.7-A-Fill your profile | r8saN | SetupProfilePage.qml | 完善资料、头像、Start（仅登录） |
| **5. Home Page** | （未设计） | — | HomePage.qml | 首页：四大入口卡片 |

---

## 2. 流程顺序（HSport.pen 按操作逻辑链分组展示）

画布已按操作逻辑链分段，每段前有 Note 引导标签：

| 分组 | 引导标签 | 帧序列 |
|------|----------|--------|
| 1. 入口 | 1. 入口 Launch | 1-Launch |
| 2. Onboarding | 2. Onboarding 引导 | 2-A → 2-B → 2-C |
| 4. Set Up | 4. Set Up 设置 | 4-A → 4.1 → 4.2 → 4.3 → 4.4 → 4.5 → 4.6 → 4.7 |
| 5. 主应用 Tab | 5. 主应用 Tab (首页/饮食/运动/健康) | 5-Home, 6-Diet, 7-Exercise, 8-Health |
| 子页面 | 子页面 (从饮食→早餐/中餐/晚餐/加餐进入) | AddFood-早餐 |

```
1-Launch → 2-A → 2-B → 2-C → 4-A → 4.1 → 4.2 → 4.3 → 4.4 → 4.5 → 4.6 → 4.7
   │         │     │     │      │     │     │     │     │     │     │     │
   └─────────┴─────┴─────┴──────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
                    Onboarding               Set Up（8 屏）
```

---

## 3. Figma 逻辑链与 HSport.pen 对应

### 3.1 已设计且已实现

| Figma 逻辑 | HSport.pen | QML |
|------------|------------|-----|
| Launch | 1-Launch | LaunchPage |
| Onboarding | 2-A/B/C | OnboardingPage |
| Set Up 4.1–4.4（合并） | 4.1–4.4 | BasicInfoPage |
| Home | — | HomePage |

### 3.2 已设计、已实现（Setup 流程）

| Figma 逻辑 | HSport.pen | QML | 说明 |
|------------|------------|-----|------|
| Set Up Intro | 4-A | SetupIntroPage | 游客+登录 |
| Set Up 4.1–4.4 | 4.1–4.4 | SetupGender/Age/Weight/HeightPage | 游客仅前 4 步 |
| Set Up 4.5–4.7 | 4.5–4.7 | SetupGoal/Activity/ProfilePage | 登录模式完整 8 步 |

### 3.3 底部导航 Tab 页（5/6/7/8）

| HSport.pen 帧名 | 帧 ID | QML 实现 | 职责说明 |
|----------------|-------|----------|----------|
| 5-Home-LoggedIn | 7FMUL | HomePage.qml | 首页： greeting、推荐内容、本周挑战、文章入口；四大分类（饮食记录/运动计划/健康报告/训练计划） |
| 6-Diet | AYws5 | DietLogPage.qml | **饮食单一真相源**：今日饮食、Macro 卡片（含阈值 减脂/正常/增加）、餐次入口、图表、食物列表 |
| 7-Exercise | 8QfC7 | ExerciseLogPage.qml | 运动记录 |
| 8-Health | G3BXs | HealthPage.qml（待实现） | **健康与规划**：本周快览、规划入口（训练计划/健康报告）、趋势与建议；**不重复展示饮食 kcal/营养素**，与 6-Diet 互补 |

### 3.4 未设计（Figma 有、HSport.pen 无）

| Figma 逻辑 | 说明 |
|------------|------|
| Login/Sign-Up 详情 | 忘记密码、重置密码 |
| Floating Menu | Profile / Notifications / Search |
| Top Menu | Workout / Progress / Nutrition / Community |
| Recommended Training | 初/中/高级 |
| Weekly Challenge | |
| Articles & Tips | |
| Button Nav | Home / Resources / Favorite / Support |

---

## 4. 使用说明

- **设计迭代**：在 HSport.pen 中新增或修改帧时，请同步更新本映射表。
- **开发实现**：实现新页面时，优先参考 HSport.pen 中对应帧的布局与样式。
- **命名规范**：HSport.pen 帧名采用「序号-子序号-描述」格式（如 4.1-A-Gender），与 Figma 节点命名对齐。

---

## 5. 参考

- **Figma 设计**：https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/?node-id=1-421
- **UI 交互逻辑**：`docs/ui-interaction-logic.md`
- **Figma 样式**：`docs/figma-design.md`

---

*随 HSport.pen 与产品迭代同步更新。*
