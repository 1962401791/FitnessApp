# HSport.pen → Figma 迁移规范

目标 Figma：[smWSqh334fyTjSJDvFXLle](https://www.figma.com/design/smWSqh334fyTjSJDvFXLle/Untitled?node-id=0-1&m=dev&t=iQP0L8r1w54TX48J-1)

本文档将 `HSport.pen` 中的 Launch 与 Onboarding 设计迁移到 Figma，包含画布结构、颜色、字体、尺寸与图片资源说明。

---

## 1. 设计变量（Design Tokens）

| 变量名 | 值 | 用途 |
|-------|-----|------|
| primary | #896CFE | 主色、Logo 框、最后一屏 CTA |
| primaryLight | #B3A0FF | 辅助色 |
| accent | #E2F163 | 强调色（HSport 标题、图标、跳过按钮） |
| cardOverlay | #896CFED9 | 底部卡片半透明紫（85% opacity） |
| textPrimary | #232323 | 深色文案（浅底时使用） |
| textMuted | #6C757D | 次要文案 |

**Figma 建议**：在 Figma 中创建 Local variables 或 Color styles，便于后续修改。

---

## 2. 画布与页面结构

整体为 4 个并排 Frame，尺寸均为 **390 × 844**，水平间距约 30px。

| 名称 | X | Y | 尺寸 |
|-----|---|---|------|
| 1-Launch | 0 | 0 | 390 × 844 |
| 2-A-Onboarding | 420 | 0 | 390 × 844 |
| 2-B-Onboarding | 840 | 0 | 390 × 844 |
| 2-C-Onboarding | 1260 | 0 | 390 × 844 |

---

## 3. 1-Launch 页面

### 3.1 层级结构

```
1-Launch (Frame 390×844)
├── launchBg (Frame 390×844, x:0 y:0)
│   └── 背景图 fill
└── launchContent (Frame 390×844, x:0 y:0) — 叠加在上方
    ├── welcomeText
    ├── logoFrame
    │   └── logoText "HS" 或 logo 图片
    ├── brandText
    └── tagline
```

### 3.2 详细规格

| 元素 | 类型 | 尺寸 | 位置 | 填充/颜色 | 其他 |
|------|------|------|------|-----------|------|
| launchBg | Frame | 390×844 | (0,0) | Image fill | 背景图，见下方资源 |
| launchContent | Frame | 390×844 | (0,0) | 无 | padding: 40, gap: 24, vertical, center |
| welcomeText | Text | — | center | #FFFFFF | "欢迎使用", Inter 18, normal |
| logoFrame | Frame | 120×120 | center | #896CFE | cornerRadius: 24 |
| logoText 或 Image | Text/Image | — | 居中于 logoFrame | #FFFFFF | "HS" Inter 48 bold，或 logo.png |
| brandText | Text | — | center | #E2F163 | "HSport", Inter 36, bold |
| tagline | Text | — | center | #FFFFFF | "健康生活 · 健身融入每一天", Inter 14, normal |

---

## 4. 2-A-Onboarding（积极生活）

### 4.1 层级结构

```
2-A-Onboarding (Frame 390×844)
├── onb1Bg (Frame 390×844, x:0 y:0) — 背景图
├── onb1Card (Frame 390×320, x:0 y:524) — 底部卡片
│   ├── onb1Icon
│   ├── onb1Title
│   ├── onb1Dots
│   └── onb1Btn
└── skip1 (Frame, x:300 y:56) — 右上角跳过
    ├── skip1Text
    └── skip1Arrow
```

### 4.2 底部卡片（onb1Card）

| 属性 | 值 |
|------|-----|
| 尺寸 | 390 × 320 |
| 位置 | (0, 524) |
| 填充 | #896CFED9 |
| 圆角 | 24, 24, 0, 0（仅顶部圆角） |
| padding | 32 |
| gap | 20 |
| layout | vertical, space_between, center |

| 子元素 | 类型 | 规格 |
|--------|------|------|
| onb1Icon | Icon/Shape | 56×56, #E2F163, lucide "activity" |
| onb1Title | Text | "开启健康生活新旅程", Inter 22 bold, #FFFFFF, 居中, width 320 |
| onb1Dots | Frame | horizontal, gap 8, center |
| onb1Dot1 | Rectangle | 24×8, radius 4, #FFFFFF |
| onb1Dot2 | Rectangle | 8×8, radius 4, rgba(255,255,255,0.4) |
| onb1Dot3 | Rectangle | 8×8, radius 4, rgba(255,255,255,0.4) |
| onb1Btn | Frame | fill width, 52h, radius 26, #4A4A4A |
| onb1BtnText | Text | "下一页", Inter 16 bold, #FFFFFF |

### 4.3 跳过按钮（skip1）

| 属性 | 值 |
|------|-----|
| 位置 | (300, 56) |
| 尺寸 | ~52 × 40 |
| gap | 6 |
| skip1Text | "跳过", Inter 14, #E2F163 |
| skip1Arrow | → 图标, 18×18, #E2F163 |

---

## 5. 2-B-Onboarding（营养建议）

结构与 2-A 相同，仅替换以下内容：

| 元素 | 变更 |
|------|------|
| onb2Bg | 背景图：onb2_bg.png |
| onb2Icon | lucide "apple" |
| onb2Title | "营养建议，融入每一天" |
| onb2Dots | 第 2 个点高亮（24×8），其余 8×8 |
| onb2Btn | 同 onb1Btn："下一页", #4A4A4A |

---

## 6. 2-C-Onboarding（同一挑战）

结构与 2-A 相同，仅替换以下内容：

| 元素 | 变更 |
|------|------|
| onb3Bg | 背景图：onb3_bg.png |
| onb3Icon | lucide "users" |
| onb3Title | "一起挑战，共同成长" |
| onb3Dots | 第 3 个点高亮 |
| onb3Btn | **"开始使用"**, fill #896CFE（主色） |

---

## 7. 图片资源

从 `HSport.pen` 或项目资源导出以下图片，并放入 Figma：

| 用途 | 源路径 | Figma 使用 |
|------|--------|------------|
| Launch 背景 | `f:\app\resources\images\onboarding\launch_bg.png` | 1-Launch / launchBg fill |
| Onboarding 1 背景 | `onb1_bg.png` | 2-A / onb1Bg fill |
| Onboarding 2 背景 | `onb2_bg.png` | 2-B / onb2Bg fill |
| Onboarding 3 背景 | `onb3_bg.png` | 2-C / onb3Bg fill |
| Logo | `f:\app\resources\images\logo.png` | Launch logoFrame 内（可选） |

图片填充模式：**Fill**，覆盖整个 Frame。

---

## 8. Figma 操作步骤（简要）

1. **创建 4 个 Frame**：390 × 844，按上述 X 坐标并排放置。
2. **设置 Local variables**：primary、accent、cardOverlay 等。
3. **1-Launch**：背景图 → 叠加居中内容（欢迎、logo 框、HSport、标语）。
4. **2-A/B/C**：每屏 = 背景图 + 底部卡片（图标、标题、点、按钮）+ 右上角跳过。
5. **导入图片**：将以下文件拖入 Figma，作为对应 Frame 的 fill：
   - `f:\app\resources\images\onboarding\launch_bg.png` → 1-Launch
   - `f:\app\resources\images\onboarding\onb1_bg.png` → 2-A
   - `f:\app\resources\images\onboarding\onb2_bg.png` → 2-B
   - `f:\app\resources\images\onboarding\onb3_bg.png` → 2-C
6. **图标**：使用 Figma 社区 Lucide 插件，或简化为占位形状/emoji。

---

## 9. 字体

- **Inter**：欢迎 18、logo 内 48、品牌 36、标语 14、卡片标题 22、按钮 16、跳过 14。
- **字重**：normal 用于欢迎/标语/跳过；bold (700) 用于 logo/品牌/标题/按钮。

---

*生成自 HSport.pen，供 Figma 迁移使用。*
