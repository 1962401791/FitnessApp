# 健身 App UI 交互逻辑链分析

> 参考 Figma 设计：[Fitness App UI Kit for Gym Workout App](https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/Fitness-App-UI-Kit-for-Gym-Workout-App-Fitness-Tracker-Mobile-App-Gym-Fitness-Mobile-App-UI-Kit--Community-?node-id=1-421&m=dev&t=VnkyTJUBKZHpGuXk-1)

本文档对 Figma 中的 UI 交互逻辑链进行结构化分析，作为后续设计迭代的参考方向。

---

## 1. 整体流程结构

### 1.1 入口与引导链路

```
Launch (1) → Onboarding (2) → Login/Sign Up (3) → Set Up (4) → Home Page (5)
```

| 阶段 | 说明 |
|------|------|
| **Launch** | App 启动入口 |
| **Onboarding** | 引导页序列，介绍产品核心价值 |
| **Login/Sign Up** | 登录/注册；含「忘记密码/重置密码」(5.1) |
| **Set Up** | 首次或登录后填写个人档案 |
| **Home Page** | 主界面中枢，所有核心模块以此为入口 |

### 1.2 档案设置（Set Up）字段

| 序号 | 字段 | 用途 |
|------|------|------|
| 4.1 | 性别 (gender) | BMR 计算系数 |
| 4.2 | 年龄 (age) | BMR 计算 |
| 4.3 | 体重 (weight) | BMR、运动消耗 |
| 4.4 | 身高 (height) | BMR 计算 |
| 4.5 | 目标 (goal) | 增肌/减脂/维持等方向 |
| 4.6 | 体力活动水平 | 日常消耗估算（TDEE） |
| 4.7 | 完成档案 | 确认并进入主界面 |

---

## 2. 主导航结构

主界面以 Home Page 为中心，分为四类入口：

| 类型 | 说明 | 典型位置 |
|------|------|----------|
| **Floating Menu (6)** | 侧边/汉堡菜单 | 左上或侧滑 |
| **Top Menu (7)** | 主标签/分区 | 顶部 Tab 或分段 |
| **Direct Features (8–10)** | 首页主内容区 | 卡片、列表 |
| **Button Nav (11)** | 底部导航栏 | 固定在底部 |

---

## 3. 详细功能矩阵

### 3.1 Floating Menu（侧边菜单）

| 入口 | 子功能 | 说明 |
|------|--------|------|
| **Profile (6.1)** | Edit Profile, Favorites, Notification, Setting, Help, Log Out | 用户中心与账号管理 |
| **Notifications (6.2)** | Workout Reminders, System Notifications | 提醒与通知 |
| **Search (6.3)** | All, Workout, Nutrition | 全局搜索（跨类型） |

### 3.2 Top Menu（主功能分区）

| 分区 | 子功能 | 说明 |
|------|--------|------|
| **Workout (7.1)** | Preset Routines (初/中/高级), Make your own routine | 训练计划与自定义 |
| **Progress tracking (7.2)** | Workout Log, Progress Charts | 运动日志与趋势图表 |
| **Nutrition (7.3)** | Meal Plans, Meal Ideas (早/午/晚餐) | 饮食计划与建议 |
| **Community (7.4)** | Discussion forum, Challenges & competitions | 社区与挑战赛 |

### 3.3 首页直接入口（卡片/区块）

| 入口 | 说明 |
|------|------|
| **Recommended training sessions (8)** | 个性化推荐训练 |
| **Weekly Challenge (9)** | 周挑战活动 |
| **Articles & Tips (10)** | 文章与技巧 |

### 3.4 底部导航栏（Button Nav）

| Tab | 子功能 | 说明 |
|-----|--------|------|
| **Home (11.1)** | — | 首页 |
| **Resources (11.2)** | Articles & Tips, Workout Videos | 资源与视频 |
| **Favorite (11.3)** | All, Video, Article | 收藏内容 |
| **Support & Help (11.4)** | Help Center, Online Support | 帮助与客服 |

---

## 4. 实现状态

- **Launch**：已实现 `LaunchPage.qml`，使用 logo.png，2s 或点击跳过。
- **Onboarding**：已实现 `OnboardingPage.qml`，3 屏 + 跳过 + 进度点 + 下一页/开始使用。
- **流程**：Launch → Onboarding → 模式选择 → 基础信息 → 首页；首次后 Launch/Onboarding 可跳过。

---

## 5. 与本项目当前规划的对比

### 4.1 已有/可对齐

| Figma 模块 | 本项目现状 | 对齐方式 |
|------------|------------|----------|
| Launch | 有 | 模式选择（游客/登录） |
| Set Up 4.1–4.4 | 有 | 基础信息：年龄、身高、体重、性别 |
| Login/Sign Up | 有 | Beta 置灰，预留 |
| Home Page | 有 | 首页快捷入口 |
| Nutrition 部分 | 有 | 饮食记录、三大营养素、时段 |
| Progress tracking 部分 | 部分 | 运动记录 + 每日总结 |
| Profile / Setting | 有 | 设置页 + 基础信息修改 |

### 4.2 暂未规划 / 可扩展

| Figma 模块 | 说明 | 建议优先级 |
|------------|------|------------|
| Onboarding 引导序列 | 多屏引导页 | P2（登录模式启用前） |
| Set Up 4.5–4.6 | 目标、活动水平 | P1（与 TDEE 关联） |
| Preset Routines | 预设训练计划（初/中/高） | P2 |
| Make your own routine | 自定义训练计划 | P3 |
| Meal Plans / Meal Ideas | 饮食计划与餐食建议 | P2 |
| Community | 论坛、挑战赛 | P3 |
| Recommended training | 推荐训练 | P3 |
| Weekly Challenge | 周挑战 | P3 |
| Resources / Workout Videos | 文章与视频资源 | P2 |
| Favorites | 收藏（视频/文章等） | P2 |
| Search | 全局搜索 | P2 |
| Notification / Reminders | 提醒与通知 | P2 |

---

## 6. 设计方向总结

1. **入口链路**：Figma 采用「启动 → 引导 → 登录 → 档案设置 → 首页」，本项目采用「启动 → 模式选择 → 基础信息 → 首页」。可逐步增加 Onboarding、完善 Set Up，并在登录模式启用后统一入口。
2. **主导航**：Figma 采用 Top Menu + Bottom Nav + Floating Menu 组合；本项目当前为首页卡片 + 设置。可优先实现底部导航（Home / 饮食 / 运动 / 设置），再考虑 Top Menu 和 Floating Menu。
3. **Nutrition 深化**：在现有饮食记录基础上，增加 Meal Plans、Meal Ideas，可与食物 API 和本地食谱库结合。
4. **Workout 深化**：在现有运动记录基础上，增加 Preset Routines、Progress Charts，与姿势矫正扩展方向一致。
5. **社区与激励**：Community、Weekly Challenge、Articles & Tips 属于增强黏性与留存的功能，可在登录模式成熟后规划。

---

## 7. 参考链接

- **Figma 设计文件**：https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/Fitness-App-UI-Kit-for-Gym-Workout-App-Fitness-Tracker-Mobile-App-Gym-Fitness-Mobile-App-UI-Kit--Community-?node-id=1-421&m=dev&t=VnkyTJUBKZHpGuXk-1
- **HSport.pen UI 逻辑映射**：`docs/hsport-pen-ui-logic-map.md`（设计稿帧与逻辑链、QML 页面的对应关系）
- **项目产品需求**：`docs/product-requirements.md`
- **Figma 样式与页面**：`docs/figma-design.md`

---

*文档维护：随 Figma 设计与产品需求迭代同步更新。*
