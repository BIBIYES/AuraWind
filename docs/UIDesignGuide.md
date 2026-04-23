# AuraWind UI 设计指南

本文档定义 AuraWind 的视觉设计语言、UI 组件规范和交互模式，确保整个应用的设计一致性和用户体验。

---

## 🎨 设计理念

### 核心概念

**发光效果 + 新拟物风格 + 液态玻璃 (Glow + Neumorphism + Liquid Glass)**
AuraWind 采用现代化的**发光效果(Glow)**、**新拟物风格(Neumorphism)**与**液态玻璃(Glassmorphism)**三位一体融合设计，创造出既炫酷又有触感深度的独特视觉体验。

**设计特点**:
- **径向渐变背景**: 多层径向渐变营造深邃空间感,模拟光线扩散
- **发光边框**: 可选的旋转发光边框动画,增加科技感
- **内发光效果**: inset box-shadow 模拟玻璃内部光线反射
- **外发光效果**: 柔和的扩散光晕,营造悬浮感
- **新拟物效果**: 模拟真实物理材质,通过内阴影和外阴影营造凸起/凹陷感
- **弥散光感**: 柔和的多层阴影,营造自然光照效果
- **液态质感**: 半透明材质和模糊效果,增加层次感
- **触感反馈**: 按压时的缩放动画,hover时的光晕增强效果
- **深浅适配**: 完整的浅色/深色模式适配

### 设计原则

1. **简洁优雅 (Simplicity & Elegance)**
   - 界面简洁，避免信息过载
   - 优雅的动画和过渡效果
   - 符合直觉的交互方式

2. **信息层级 (Visual Hierarchy)**
   - 清晰的视觉层级
   - 重要信息突出显示
   - 合理的空间布局

3. **一致性 (Consistency)**
   - 统一的设计语言
   - 一致的交互模式
   - 规范的组件使用

4. **可访问性 (Accessibility)**
   - 支持深色/浅色模式
   - VoiceOver 支持
   - 键盘导航友好

---

## 🌈 配色方案

### Logo 品牌色系

AuraWind 的配色方案完全基于实际 Logo 颜色,营造清新、现代、简约的视觉风格。

```swift
// Logo 品牌色系 (按占比从大到小)
extension Color {
    // 主背景色 - 浅蓝灰
    static let auraBackground = Color(red: 229/255, green: 237/255, blue: 246/255)  // #E5EDF6
    
    // 柔和蓝色
    static let auraSoftBlue = Color(red: 207/255, green: 221/255, blue: 245/255)    // #CFDDF5
    
    // 浅灰白色
    static let auraLightGray = Color(red: 242/255, green: 245/255, blue: 244/255)   // #F2F5F4
    
    // 明亮蓝色 - 主色调 ⭐
    static let auraBrightBlue = Color(red: 103/255, green: 172/255, blue: 240/255)  // #67ACF0
    
    // 淡青色
    static let auraCyan = Color(red: 219/255, green: 247/255, blue: 247/255)        // #DBF7F7
    
    // 中蓝色
    static let auraMediumBlue = Color(red: 178/255, green: 210/255, blue: 243/255)  // #B2D2F3
    
    // 天蓝色
    static let auraSkyBlue = Color(red: 133/255, green: 208/255, blue: 244/255)     // #85D0F4
    
    // 极淡青色
    static let auraPaleCyan = Color(red: 230/255, green: 247/255, blue: 244/255)    // #E6F7F4
    
    // 半透明白色 (玻璃效果)
    static let auraGlassWhite = Color(red: 246/255, green: 249/255, blue: 249/255)
        .opacity(96/255)  // rgba(246, 249, 249, 96)
    
    // 便捷别名
    static let auraPrimary = auraBrightBlue      // 主色调
    static let auraSecondary = auraMediumBlue    // 次要色
    static let auraAccent = auraSkyBlue          // 强调色
    
    // 功能色
    static let statusNormal = Color.green
    static let statusWarning = Color.orange
    static let statusDanger = Color.red
    static let statusInfo = auraBrightBlue
}
```

### 液态玻璃 + 新拟物效果色

```swift
extension Color {
    // 玻璃背景 - 使用 Logo 半透明白
    static let glassBackground = auraGlassWhite
    
    // 玻璃边框 - 淡青色边框
    static let glassBorder = auraPaleCyan.opacity(0.6)
    
    // 玻璃高光 - 明亮区域
    static let glassHighlight = auraLightGray.opacity(0.8)
    
    // 玻璃阴影 - 柔和蓝色阴影
    static let glassShadow = auraSoftBlue.opacity(0.3)
    
    // 新拟物阴影
    static let shadowLight = Color.white.opacity(0.8)          // 浅色阴影 (凸起)
    static let shadowDark = auraSoftBlue.opacity(0.2)          // 深色阴影 (凹陷)
    static let shadowAmbient = auraBrightBlue.opacity(0.05)    // 环境阴影
}
```

### 深色模式适配

```swift
extension Color {
    static func adaptive(light: Color, dark: Color) -> Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
    
    // 自适应背景
    static let adaptiveBackground = adaptive(
        light: Color(white: 0.98),
        dark: Color(white: 0.08)
    )
    
    // 自适应文本
    static let adaptiveText = adaptive(
        light: Color.black,
        dark: Color.white
    )
}
```

### 色彩使用场景

| 颜色 | RGB 值 | 用途 | 示例 |
|------|--------|------|------|
| **明亮蓝** | 103, 172, 240 | 主色调、主要操作 | 按钮、链接、标题 |
| **天蓝色** | 133, 208, 244 | 强调、高亮 | 图标、动画、hover 状态 |
| **中蓝色** | 178, 210, 243 | 次要元素 | 辅助文字、次要按钮 |
| **柔和蓝** | 207, 221, 245 | 背景、分隔 | 卡片背景、分隔线 |
| **浅蓝灰** | 229, 237, 246 | 主背景 | 窗口背景、大面积背景 |
| **浅灰白** | 242, 245, 244 | 卡片主体 | 卡片、面板 |
| **淡青色** | 219, 247, 247 | 装饰、边框 | 边框、装饰元素 |
| **极淡青** | 230, 247, 244 | 微妙装饰 | 细微装饰、渐变 |
| **Green** | 系统色 | 正常状态 | 风扇正常、温度正常 |
| **Orange** | 系统色 | 警告状态 | 温度偏高、注意 |
| **Red** | 系统色 | 危险状态 | 过热、错误、停止 |

### 设计风格特点

**简约现代美学**
- 清新的蓝色系为主调
- 大量留白营造呼吸感
- 柔和的渐变过渡
- 避免过度装饰

**液态玻璃效果**
- 半透明材质 (ultraThinMaterial)
- 模糊背景营造深度感
- 淡青色边框增加层次
- 柔和的光影变化

**新拟物风格** (Neumorphism) - 核心风格
- **内阴影(Inset Shadow)**: 模拟 CSS `box-shadow: inset` 效果
  - 凸起状态: 顶部左侧高光 + 底部右侧阴影
  - 凹陷状态: 顶部左侧阴影 + 底部右侧高光
- **外部弥散阴影**: 多层柔和阴影营造浮起感
  - 深色阴影: 右下方向,模拟投影
  - 浅色阴影: 左上方向,增加立体感
  - 环境光: 全方向扩散,增加柔和度
- **背景融合**: 组件背景色接近主背景色(auraLightGray)
- **交互状态**:
  - Normal: 凸起效果
  - Pressed: 凹陷效果(inset shadow)
  - Hover: 额外光晕
  - Selected: 内部高亮 + 边框加粗

---

## 📐 布局与间距

### 间距系统

```swift
enum Spacing {
    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}
```

### 圆角规范

```swift
enum CornerRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let full: CGFloat = 999
}
```

### 布局网格

- **基础单位**: 8pt
- **最小间距**: 8pt
- **卡片间距**: 16pt
- **段落间距**: 24pt
- **内容边距**: 16-24pt

### 响应式布局

```swift
struct ResponsiveLayout {
    // 窗口尺寸断点
    static let compact: CGFloat = 600      // 紧凑布局
    static let regular: CGFloat = 900      // 常规布局
    static let expanded: CGFloat = 1200    // 扩展布局
    
    // 自适应间距
    static func spacing(for width: CGFloat) -> CGFloat {
        switch width {
        case 0..<compact:
            return Spacing.sm
        case compact..<regular:
            return Spacing.md
        default:
            return Spacing.lg
        }
    }
}
```

---

## 🎭 视觉效果

### 🌟 发光卡片效果 (GlowCard) - 最新推荐

#### 设计理念
完全模拟你提供的CSS炫酷卡片效果,包括:
- 多层径向渐变背景(深色模式4层,浅色模式3层)
- 内发光效果(inset shadow)
- 外发光阴影
- 可选的旋转发光边框动画

#### 核心特性

**深色模式 - 径向渐变系统**:
```swift
// 基础深色背景
Color.auraDarkCard  // rgb(20, 30, 48)

// 层1 - 中心深色区域
RadialGradient(
    colors: [Color.radialDarkCenter, Color.clear],
    center: .center,
    startRadius: 0, endRadius: 200
)

// 层2 - 左上蓝色光晕
RadialGradient(
    colors: [Color.radialBlueGlow1, Color.clear],  // rgb(26, 99, 137)
    center: UnitPoint(x: 0.2, y: 0.3),
    startRadius: 0, endRadius: 150
)

// 层3 - 右下蓝色光晕
RadialGradient(
    colors: [Color.radialBlueGlow2, Color.clear],  // rgb(36, 137, 191)
    center: UnitPoint(x: 0.8, y: 0.7),
    startRadius: 0, endRadius: 180
)

// 层4 - 边缘浅蓝
RadialGradient(
    colors: [Color.clear, Color.radialLightEdge],  // rgb(13, 94, 133)
    center: .bottomTrailing,
    startRadius: 50, endRadius: 200
)
```

**浅色模式 - 柔和渐变**:
```swift
// 基础浅色背景
Color.auraLightGray.opacity(0.95)

// 柔和线性渐变
LinearGradient(
    colors: [
        Color.auraLightGray.opacity(0.4),
        Color.auraPaleCyan.opacity(0.2),
        Color.auraGlassWhite
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

// 微妙径向光晕
RadialGradient(
    colors: [Color.auraBrightBlue.opacity(0.05), Color.clear],
    center: .topLeading,
    startRadius: 0, endRadius: 200
)
```

**内发光效果**:
```swift
.overlay(
    RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(
            LinearGradient(
                colors: [
                    Color.white.opacity(colorScheme == .dark ? 0.25 : 0.6),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            lineWidth: 1
        )
        .shadow(color: cardInnerGlowColor, radius: 16, x: 0, y: -8)
        .blur(radius: 8)
)
```

**旋转发光边框(可选)**:
```swift
RoundedRectangle(cornerRadius: cornerRadius)
    .stroke(
        AngularGradient(
            colors: [
                Color.clear,
                Color.auraBrightBlue.opacity(0.8),
                Color.auraSkyBlue,
                Color.auraBrightBlue.opacity(0.8),
                Color.clear
            ],
            center: .center,
            angle: .degrees(rotation)  // 动画旋转
        ),
        lineWidth: 2
    )
    .blur(radius: 4)
    .onAppear {
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            rotation = 360
        }
    }
```

#### 使用示例

**基础卡片**:
```swift
GlowCard(colorScheme: .light) {
    VStack(alignment: .leading, spacing: 12) {
        Text("CPU 温度")
            .font(.caption)
        Text("65°C")
            .font(.system(size: 48, weight: .bold))
    }
}
```

**带动画边框**:
```swift
GlowCard(showAnimatedBorder: true, colorScheme: .dark) {
    VStack {
        Image(systemName: "wind")
            .font(.system(size: 40))
        Text("AuraWind")
            .font(.title2.bold())
    }
}
```

---

### 新拟物 + 液态玻璃效果 (LiquidGlassCard) - 保留兼容

#### 增强版液态玻璃卡片

**核心改进**:
1. **内阴影模拟**: 使用渐变 + 模糊实现 CSS `inset shadow` 效果
2. **更强弥散感**: 三层外阴影(深色、浅色、环境光)
3. **背景融合**: 使用 auraLightGray 作为基础,更接近背景
4. **细腻边框**: 三色渐变边框,增加精致感

#### 实现代码

```swift
struct LiquidGlassCard<Content: View>: View {
    let content: Content
    var intensity: GlassIntensity = .medium
    
    enum GlassIntensity {
        case light, medium, heavy
        
        var opacity: Double {
            switch self {
            case .light: return 0.05
            case .medium: return 0.1
            case .heavy: return 0.15
            }
        }
        
        var blurRadius: CGFloat {
            switch self {
            case .light: return 10
            case .medium: return 20
            case .heavy: return 30
            }
        }
    }
    
    init(
        intensity: GlassIntensity = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.intensity = intensity
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(Spacing.md)
            .background(glassBackground)
            .overlay(glassBorder)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg))
            .shadow(
                color: Color.shadowMedium,
                radius: 10,
                y: 5
            )
    }
    
    private var glassBackground: some View {
        ZStack {
            // 背景模糊
            Color.white.opacity(intensity.opacity)
                .background(.ultraThinMaterial)
            
            // 渐变光泽
            LinearGradient(
                colors: [
                    Color.auraBlue.opacity(0.1),
                    Color.auraPurple.opacity(0.05),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: intensity.blurRadius)
        }
    }
    
    private var glassBorder: some View {
        RoundedRectangle(cornerRadius: CornerRadius.lg)
            .strokeBorder(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
```

**新拟物内阴影实现**:
```swift
private var neumorphicBackground: some View {
    ZStack {
        // 顶部/左侧 内凹阴影 (深色) - 模拟 inset 4px 4px
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: [
                        Color.auraSoftBlue.opacity(0.25),  // 深色阴影
                        Color.clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 8)
            .padding(2)
        
        // 底部/右侧 内凹高光 (浅色) - 模拟 inset -4px -4px
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.white.opacity(0.4)  // 浅色高光
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 8)
            .padding(2)
    }
    .allowsHitTesting(false)
}
```

**外部弥散阴影**:
```swift
.shadow(color: .shadowDark, radius: 12, x: 6, y: 6)      // 右下深色
.shadow(color: .shadowLight, radius: 12, x: -6, y: -6)   // 左上浅色
.shadow(color: .shadowAmbient.opacity(0.5), radius: 25)   // 环境光
```

#### 使用示例

```swift
// 基础使用
LiquidGlassCard {
    VStack(alignment: .leading, spacing: Spacing.sm) {
        Text("CPU 温度")
            .font(.headline)
        Text("65°C")
            .font(.system(size: 48, weight: .bold))
    }
}

// 自定义强度
LiquidGlassCard(intensity: .heavy) {
    // 内容
}
```

### 发光效果

```swift
struct GlowModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.5), radius: radius)
            .shadow(color: color.opacity(0.3), radius: radius * 2)
            .shadow(color: color.opacity(0.1), radius: radius * 3)
    }
}

extension View {
    func glow(color: Color, radius: CGFloat = 10) -> some View {
        modifier(GlowModifier(color: color, radius: radius))
    }
}

// 使用示例
Text("AuraWind")
    .foregroundColor(.auraBlue)
    .glow(color: .auraBlue, radius: 8)
```

### 模糊背景

```swift
struct BlurredBackground: View {
    var body: some View {
        ZStack {
            // 渐变背景
            LinearGradient(
                colors: [
                    Color.auraBlue.opacity(0.3),
                    Color.auraPurple.opacity(0.3),
                    Color.auraYellow.opacity(0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: 100)
            
            // 材质效果
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}
```

---

## 🧩 UI 组件库

### 按钮组件

#### Neumorphic Button (新拟物按钮)

**设计理念**:
完全模拟 CSS Neumorphism 按钮效果,包括:
- 正常状态: 凸起效果(外阴影 + 内高光)
- 按下状态: 凹陷效果(内阴影 inset)
- Hover状态: 弥散光晕
- 选中状态: 内部高亮 + 彩色边框

**核心特性**:
```swift
struct NeumorphicButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var style: ButtonStyle = .primary
    var isSelected: Bool = false
    
    @State private var isPressed = false
    @State private var isHovered = false
    
    enum ButtonStyle {
        case primary, secondary, success, warning, danger
    }
}
```

**视觉效果**:
```swift
// 正常状态 - 凸起
.shadow(color: .shadowDark, radius: 8, x: 4, y: 4)
.shadow(color: .shadowLight, radius: 8, x: -4, y: -4)

// 按下状态 - 凹陷 (清除外阴影,显示内阴影)
.shadow(color: .clear, radius: 0)  // 移除外阴影
// + 内阴影渐变层显示

// Hover状态 - 光晕
.shadow(color: style.color.opacity(0.3), radius: 15)
```

**使用示例**:
```swift
// 基础按钮
NeumorphicButton(
    title: "应用设置",
    icon: "checkmark.circle.fill",
    style: .primary
) {
    applySettings()
}

// 选中状态按钮
NeumorphicButton(
    title: "静音模式",
    icon: "speaker.wave.1",
    style: .primary,
    isSelected: currentMode == .silent
) {
    changeMode(.silent)
}

// 图标按钮
NeumorphicButton(
    title: "",
    icon: "play.fill",
    style: .success
) {
    startMonitoring()
}
.frame(width: 60, height: 60)
```

#### Glass Button (遗留组件,逐步替换为 NeumorphicButton)

```swift
struct GlassButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    var style: ButtonStyle = .primary
    
    enum ButtonStyle {
        case primary, secondary, danger
        
        var color: Color {
            switch self {
            case .primary: return .auraBlue
            case .secondary: return .gray
            case .danger: return .red
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(buttonBackground)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md))
        }
        .buttonStyle(.plain)
    }
    
    private var buttonBackground: some View {
        ZStack {
            style.color.opacity(0.8)
                .background(.ultraThinMaterial)
            
            LinearGradient(
                colors: [
                    style.color.opacity(0.6),
                    style.color.opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// 使用示例
GlassButton(
    title: "应用",
    icon: "checkmark.circle.fill",
    action: { /* 处理点击 */ },
    style: .primary
)
```

### 滑块组件

#### Glass Slider

```swift
struct GlassSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double = 1
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(value))")
                    .font(.headline)
                    .foregroundColor(.auraBlue)
                    .monospacedDigit()
            }
            
            Slider(
                value: $value,
                in: range,
                step: step
            )
            .tint(.auraBlue)
            .overlay(sliderTrack)
        }
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .fill(.ultraThinMaterial)
        )
    }
    
    private var sliderTrack: some View {
        GeometryReader { geometry in
            let progress = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
            let width = geometry.size.width * progress
            
            RoundedRectangle(cornerRadius: 2)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.auraBlue.opacity(0.3),
                            Color.auraPurple.opacity(0.3)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: width, height: 4)
                .blur(radius: 3)
                .allowsHitTesting(false)
        }
        .frame(height: 4)
    }
}

// 使用示例
@State private var fanSpeed: Double = 3000

GlassSlider(
    value: $fanSpeed,
    range: 1000...6000,
    step: 100,
    label: "风扇转速"
)
```

### 卡片组件

#### Info Card

```swift
struct InfoCard: View {
    let title: String
    let value: String
    let unit: String?
    let icon: String
    var status: StatusLevel = .normal
    
    enum StatusLevel {
        case normal, warning, danger
        
        var color: Color {
            switch self {
            case .normal: return .green
            case .warning: return .orange
            case .danger: return .red
            }
        }
    }
    
    var body: some View {
        LiquidGlassCard {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(status.color)
                        .glow(color: status.color, radius: 5)
                    
                    Spacer()
                    
                    Circle()
                        .fill(status.color)
                        .frame(width: 8, height: 8)
                        .glow(color: status.color, radius: 3)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(value)
                        .font(.system(size: 36, weight: .bold))
                        .monospacedDigit()
                    
                    if let unit = unit {
                        Text(unit)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// 使用示例
InfoCard(
    title: "CPU 温度",
    value: "65",
    unit: "°C",
    icon: "cpu.fill",
    status: .normal
)
```

### 开关组件

#### Glass Toggle

```swift
struct GlassToggle: View {
    let title: String
    let subtitle: String?
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.auraBlue)
        }
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .strokeBorder(
                            Color.glassBorder,
                            lineWidth: 1
                        )
                )
        )
    }
}

// 使用示例
@State private var autoStart = false

GlassToggle(
    title: "开机启动",
    subtitle: "系统启动时自动运行 AuraWind",
    isOn: $autoStart
)
```

---

## 📊 图表样式

### 温度图表

```swift
struct TemperatureChart: View {
    let dataPoints: [DataPoint]
    
    struct DataPoint: Identifiable {
        let id = UUID()
        let timestamp: Date
        let value: Double
    }
    
    var body: some View {
        LiquidGlassCard(intensity: .light) {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("温度趋势")
                    .font(.headline)
                
                Chart(dataPoints) { point in
                    LineMark(
                        x: .value("时间", point.timestamp),
                        y: .value("温度", point.value)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.auraBlue, .auraPurple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                    
                    AreaMark(
                        x: .value("时间", point.timestamp),
                        y: .value("温度", point.value)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color.auraBlue.opacity(0.3),
                                Color.auraPurple.opacity(0.1)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(Color.gray.opacity(0.2))
                        AxisValueLabel()
                            .foregroundStyle(.secondary)
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(Color.gray.opacity(0.2))
                        AxisValueLabel {
                            if let temp = value.as(Double.self) {
                                Text("\(Int(temp))°C")
                            }
                        }
                        .foregroundStyle(.secondary)
                    }
                }
                .frame(height: 200)
            }
        }
    }
}
```

---

## ✨ 动画效果

### 动画规范

```swift
enum AnimationDuration {
    static let fast: Double = 0.2
    static let normal: Double = 0.3
    static let slow: Double = 0.5
}

enum AnimationCurve {
    static let easeIn = Animation.easeIn(duration: AnimationDuration.normal)
    static let easeOut = Animation.easeOut(duration: AnimationDuration.normal)
    static let easeInOut = Animation.easeInOut(duration: AnimationDuration.normal)
    static let spring = Animation.spring(response: 0.3, dampingFraction: 0.7)
}
```

### 风扇旋转动画

```swift
struct RotatingFanIcon: View {
    let speed: Int
    @State private var rotation: Double = 0
    
    var body: some View {
        Image(systemName: "fan.fill")
            .font(.system(size: 48))
            .foregroundStyle(
                LinearGradient(
                    colors: [.auraBlue, .auraPurple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .rotationEffect(.degrees(rotation))
            .animation(
                .linear(duration: animationDuration)
                    .repeatForever(autoreverses: false),
                value: rotation
            )
            .onAppear {
                rotation = 360
            }
    }
    
    private var animationDuration: Double {
        // 转速越高，旋转越快
        let minSpeed = 1000.0
        let maxSpeed = 6000.0
        let normalized = (Double(speed) - minSpeed) / (maxSpeed - minSpeed)
        return 2.0 - (normalized * 1.5) // 0.5-2秒
    }
}
```

### 淡入淡出

```swift
extension View {
    func fadeInOut(isVisible: Bool) -> some View {
        self
            .opacity(isVisible ? 1 : 0)
            .animation(AnimationCurve.easeInOut, value: isVisible)
    }
}
```

### 滑动进入

```swift
extension View {
    func slideIn(from edge: Edge, isVisible: Bool) -> some View {
        self
            .offset(
                x: edge == .leading && !isVisible ? -100 : (edge == .trailing && !isVisible ? 100 : 0),
                y: edge == .top && !isVisible ? -100 : (edge == .bottom && !isVisible ? 100 : 0)
            )
            .opacity(isVisible ? 1 : 0)
            .animation(AnimationCurve.spring, value: isVisible)
    }
}
```

---

## 🎯 交互模式

### 点击反馈

```swift
struct TapFeedback: ViewModifier {
    @State private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .opacity(isPressed ? 0.8 : 1.0)
            .animation(AnimationCurve.easeInOut, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}

extension View {
    func tapFeedback() -> some View {
        modifier(TapFeedback())
    }
}
```

### 悬停效果

```swift
struct HoverEffect: ViewModifier {
    @State private var isHovered = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isHovered ? 1.05 : 1.0)
            .shadow(
                color: .auraBlue.opacity(isHovered ? 0.3 : 0),
                radius: isHovered ? 15 : 0
            )
            .animation(AnimationCurve.spring, value: isHovered)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

extension View {
    func hoverEffect() -> some View {
        modifier(HoverEffect())
    }
}
```

---

## 📱 图标系统

### SF Symbols 使用规范

```swift
enum AppIcon {
    // 温度相关
    static let temperature = "thermometer"
    static let cpuChip = "cpu.fill"
    static let gpuChip = "sparkles"
    static let ambient = "thermometer.medium"
    
    // 风扇相关 (使用三叶风扇图标)
    static let fan = "wind"                    // 三叶风扇 (主图标) ⭐
    static let fanCircle = "wind.circle"       // 带圆圈的风扇
    static let fanCircleFill = "wind.circle.fill"
    static let airFlow = "wind.snow"           // 气流效果
    
    // 控制相关
    static let play = "play.circle.fill"
    static let pause = "pause.circle.fill"
    static let stop = "stop.circle.fill"
    static let settings = "gearshape.fill"
    
    // 状态相关
    static let success = "checkmark.circle.fill"
    static let warning = "exclamationmark.triangle.fill"
    static let error = "xmark.circle.fill"
    static let info = "info.circle.fill"
    
    // 图表相关
    static let chart = "chart.xyaxis.line"
    static let chartBar = "chart.bar.fill"
    static let chartLine = "chart.line.uptrend.xyaxis"
}

// 图标颜色搭配
extension View {
    func iconStyle(for type: IconType) -> some View {
        switch type {
        case .fan:
            self.foregroundStyle(LinearGradient.auraPrimary)
        case .temperature:
            self.foregroundColor(.auraBrightBlue)
        case .success:
            self.foregroundColor(.statusNormal)
        case .warning:
            self.foregroundColor(.statusWarning)
        case .error:
            self.foregroundColor(.statusDanger)
        }
    }
}
```

---

## 🔤 字体规范

### 字体层级

```swift
enum Typography {
    // 标题
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let title1 = Font.system(size: 28, weight: .bold)
    static let title2 = Font.system(size: 22, weight: .bold)
    static let title3 = Font.system(size: 20, weight: .semibold)
    
    // 正文
    static let body = Font.system(size: 17, weight: .regular)
    static let bodyBold = Font.system(size: 17, weight: .semibold)
    static let callout = Font.system(size: 16, weight: .regular)
    
    // 辅助
    static let subheadline = Font.system(size: 15, weight: .regular)
    static let footnote = Font.system(size: 13, weight: .regular)
    static let caption = Font.system(size: 12, weight: .regular)
    static let caption2 = Font.system(size: 11, weight: .regular)
    
    // 等宽数字
    static func monospaced(_ font: Font) -> Font {
        font.monospacedDigit()
    }
}
```

---

## ♿️ 可访问性

### VoiceOver 支持

```swift
extension View {
    func accessibilitySetup(
        label: String,
        hint: String? = nil,
        value: String? = nil
    ) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityHint(hint ?? "")
            .accessibilityValue(value ?? "")
    }
}

// 使用示例
InfoCard(...)
    .accessibilitySetup(
        label: "CPU 温度",
        hint: "当前处理器温度",
        value: "65摄氏度，正常"
    )
```

### 动态字体

```swift
extension View {
    func dynamicTypeSize() -> some View {
        self.dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}
```

---

## 📐 布局示例

### 主窗口布局

```swift
struct MainWindowLayout: View {
    var body: some View {
        NavigationSplitView {
            // Sidebar - 200pt 固定宽度
            SidebarView()
                .frame(minWidth: 200, idealWidth: 220, maxWidth: 250)
        } detail: {
            // Detail - 自适应宽度
            DetailView()
                .frame(minWidth: 600)
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}
```

### 网格布局

```swift
struct GridLayoutExample: View {
    let columns = [
        GridItem(.adaptive(minimum: 200, maximum: 300), spacing: Spacing.md)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Spacing.md) {
                ForEach(items) { item in
                    ItemCard(item: item)
                }
            }
            .padding(Spacing.md)
        }
    }
}
```

---

## 📋 设计检查清单

### 视觉检查
- [ ] 配色符合主题
- [ ] 字体大小合适
- [ ] 间距统一
- [ ] 对齐正确
- [ ] 图标清晰

### 交互检查
- [ ] 点击反馈明显
- [ ] 悬停效果流畅
- [ ] 动画自然
- [ ] 加载状态清晰
- [ ] 错误提示友好

### 响应式检查
- [ ] 不同窗口大小适配
- [ ] 深色/浅色模式适配
- [ ] 字体大小可调
- [ ] 布局不溢出

### 可访问性检查
- [ ] VoiceOver 可用
- [ ] 键盘导航流畅
- [ ] 颜色对比度足够
- [ ] 文本可读性好

---

## 🎨 设计资源

### Figma 设计文件
- 组件库: `AuraWind-Components.fig`
- 主题色板: `AuraWind-Colors.fig`
- 图标集: `AuraWind-Icons.fig`

### 导出资产
- App Icon: 1024x1024px
- 截图: 2880x1800px (Retina)
- 宣传图: 根据 App Store 要求

---

**设计版本**: 1.0.0  
**最后更新**: 2025-11-16 21:11
**设计团队**: AuraWind Design Team

---

## 🌀 三叶风扇 Logo 设计说明

### Logo 特点

**图标**: `wind` (SF Symbol)
- 三叶设计,简洁现代
- 符合品牌 AuraWind (风之灵韵) 的理念
- 与四叶风扇相比更加轻盈优雅

**配色**: 基于 Logo 蓝色系
- 主色: `rgb(103, 172, 240)` - 明亮蓝
- 渐变: 明亮蓝 → 天蓝色
- 效果: 发光效果增强视觉冲击

### 应用场景

1. **App 图标**: 作为应用主图标
2. **启动页**: 大尺寸 Logo 展示
3. **主界面**: 品牌标识展示
4. **菜单栏**: 系统托盘图标
5. **风扇控制**: 风扇相关功能图标

### 设计原则

**简约**: 去除多余装饰
**现代**: 符合当代审美
**识别**: 一眼认出品牌
**和谐**: 与整体UI风格统一

---

**设计版本**: 1.1.0  
**最后更新**: 2025-11-16 21:37
**设计团队**: AuraWind Design Team