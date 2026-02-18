# Figma 设计规范对齐

参考： [Fitness App UI Kit - Figma Community](https://www.figma.com/design/6yDwvHBGFzG1e5jxZzgkxJ/Fitness-App-UI-Kit--Community-)

> **UI 逻辑链映射**：设计稿与逻辑链的帧级对应见 `docs/hsport-pen-ui-logic-map.md`

## 设计 Token（StyleConstants.qml）

| Token | Figma 值 | 用途 |
|-------|----------|------|
| primary | #896CFE | 主色、按钮、强调 |
| primaryLight | #B3A0FF | 主色浅、辅助 |
| primaryPale | #C6B8FF | 浅紫背景 |
| accent | #E2F163 | 强调色（黄绿） |
| background | #FFFFFF | 背景 |
| backgroundSecondary | #F8F8F8 | 次级背景 |
| surfaceGray | #D9D9D9 | 中性灰、禁用 |
| textPrimary | #232323 | 主文字 |
| textMuted | #6C757D | 次要文字 |
| radiusLarge / radiusXLarge | 24 / 26 px | 圆角（按钮、卡片） |

## 页面与交互

- **启动页 (Launch)**：欢迎使用 + HSport 品牌 + 健康生活 · 健身融入每一天（详见 `HSport.pen` 1-Launch）
- **Onboarding**：3 屏引导（开启健康生活新旅程 / 营养建议，融入每一天 / 一起挑战，共同成长），含跳过、进度点、下一页/开始使用（详见 `HSport.pen` 2-A/B/C-Onboarding）
- **模式选择**：游客/登录，Beta 登录置灰；Logo 占位
- **基础信息页**：年龄、身高必填；体重、性别选填
- **首页**：今日摄入概览卡 + 四个入口卡片
- **饮食/运动**：列表 + 添加；时段选择（早/中/晚/加餐）
- **每日总结**：摄入、三大营养素与目标对比
- **设置**：每日目标、基础信息修改

## Logo

- **程序内部**：使用 `resources/images/logo.svg`（矢量、无背景），ModeSelectPage、HomePage 通过 `Image { source: StyleConstants.logoPath }` 显示，依赖 Qt6::Svg。
- **Android 桌面图标**：使用 `logo.png`，生成 `drawable/ic_launcher_foreground.png` 及 `mipmap-*/ic_launcher.png`。
