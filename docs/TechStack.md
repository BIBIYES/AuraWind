# AuraWind 技术栈文档

本文档详细描述 AuraWind 项目使用的技术栈、框架、工具和库。

---

## 📋 目录

1. [核心技术](#核心技术)
2. [开发框架](#开发框架)
3. [依赖库](#依赖库)
4. [开发工具](#开发工具)
5. [CI/CD](#cicd)
6. [版本要求](#版本要求)

---

## 🎯 核心技术

### Swift 5.9

**官方网站**: https://swift.org  
**选择理由**:
- 苹果官方推荐的开发语言
- 现代化的语法特性
- 强大的类型安全
- 优秀的性能表现
- async/await 并发支持

**主要特性使用**:
- async/await 异步编程
- Protocol-Oriented Programming
- Generics 泛型编程
- Property Wrappers
- Result Builders

```swift
// 示例：使用 async/await
func readTemperature() async throws -> Double {
    let temp = try await smcService.readTemperature(sensor: .cpu)
    return temp
}

// 示例：使用 Property Wrappers
@Published var temperature: Double = 0.0
@State private var isMonitoring = false
```

---

### SwiftUI

**官方文档**: https://developer.apple.com/documentation/swiftui  
**版本**: iOS 16.0+ / macOS 13.0+  
**选择理由**:
- 声明式 UI 编程范式
- 原生性能和集成
- 自动处理状态更新
- 跨平台支持
- 现代化的设计模式

**核心组件使用**:
```swift
// Views
- View, ViewModifier, ViewBuilder
- NavigationStack, NavigationSplitView
- List, ScrollView, LazyVGrid
- Sheet, Alert, ConfirmationDialog

// State Management
- @State, @StateObject, @ObservedObject
- @Published, @Binding, @Environment
- @EnvironmentObject, @AppStorage

// Layout
- VStack, HStack, ZStack
- GeometryReader, Spacer
- Divider, Group

// Charts (macOS 13.0+)
- Chart, LineMark, AreaMark
- AxisMarks, Legend
```

---

### Combine

**官方文档**: https://developer.apple.com/documentation/combine  
**选择理由**:
- 响应式编程支持
- 与 SwiftUI 深度集成
- 处理异步事件流
- 强大的操作符

**使用场景**:
```swift
// 数据流处理
Publishers.CombineLatest(temperaturePublisher, fanSpeedPublisher)
    .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
    .sink { temp, speed in
        updateUI(temperature: temp, speed: speed)
    }

// 定时器
Timer.publish(every: 1.0, on: .main, in: .common)
    .autoconnect()
    .sink { _ in
        updateData()
    }
```

---

## 🏗️ 开发框架

### IOKit Framework

**用途**: 与硬件层交互  
**主要功能**:
- SMC (System Management Controller) 访问
- 温度传感器读取
- 风扇控制

```swift
import IOKit

// SMC 连接
let service = IOServiceGetMatchingService(
    kIOMainPortDefault,
    IOServiceMatching("AppleSMC")
)

// 读取 SMC 数据
IOServiceOpen(service, mach_task_self_, 0, &connection)
```

---

### Foundation

**标准库**: Swift 标准框架  
**主要使用**:
- Date, Calendar, DateFormatter
- UserDefaults, FileManager
- URLSession, JSONEncoder/Decoder
- NotificationCenter, Timer

---

### AppKit (部分功能)

**用途**: macOS 特定功能  
**主要使用**:
- NSApplication
- NSMenu, NSMenuItem
- NSStatusBar, NSStatusItem
- NSWindow 控制

```swift
// 菜单栏图标
let statusItem = NSStatusBar.system.statusItem(
    withLength: NSStatusItem.variableLength
)
statusItem.button?.image = NSImage(systemSymbolName: "fan.fill", accessibilityDescription: nil)
```

---

## 📦 依赖库

### Swift Package Manager

**包管理器**: 官方 Swift 包管理工具  
**配置文件**: `Package.swift` 或 Xcode 项目集成

---

### 计划中的依赖

#### 1. Charts（系统内置）

**用途**: 数据可视化  
**集成方式**: SwiftUI 原生支持（macOS 13.0+）

```swift
import Charts

Chart(dataPoints) { point in
    LineMark(
        x: .value("时间", point.timestamp),
        y: .value("温度", point.value)
    )
}
```

---

#### 2. OSLog（系统内置）

**用途**: 日志记录  
**集成方式**: Foundation 框架

```swift
import OSLog

let logger = Logger(subsystem: "com.aurawind.app", category: "SMC")
logger.info("Temperature read: \(temp)°C")
logger.error("SMC connection failed: \(error)")
```

---

#### 3. 可选：第三方库

根据实际需求，可能会集成以下库：

##### SwiftLint
**用途**: 代码风格检查  
**仓库**: https://github.com/realm/SwiftLint  
**安装**: Homebrew 或 CocoaPods

```bash
brew install swiftlint
```

##### Defaults
**用途**: 更好的 UserDefaults 包装  
**仓库**: https://github.com/sindresorhus/Defaults  
**集成**: Swift Package Manager

```swift
.package(url: "https://github.com/sindresorhus/Defaults", from: "7.0.0")
```

---

## 🛠️ 开发工具

### Xcode

**版本**: 15.0+  
**用途**: 主要开发 IDE  
**特性**:
- Swift 编译器
- Interface Builder
- Instruments 性能分析
- 测试框架集成
- Source Control 集成

**推荐插件**:
- SwiftLint for Xcode
- SourceKitten

---

### Git

**版本**: 2.0+  
**用途**: 版本控制  
**工作流**: Git Flow

```bash
# 主要分支
main        # 生产版本
develop     # 开发分支

# 功能分支
feature/*   # 新功能
bugfix/*    # Bug 修复
hotfix/*    # 紧急修复
```

---

### Homebrew

**用途**: macOS 包管理器  
**安装工具**:
```bash
brew install swiftlint
brew install git
```

---

## 🔧 开发辅助工具

### 代码质量

#### SwiftLint
**配置文件**: `.swiftlint.yml`

```yaml
disabled_rules:
  - trailing_whitespace
  
opt_in_rules:
  - empty_count
  - explicit_init
  
included:
  - AuraWind
  
excluded:
  - Pods
  - AuraWindTests

line_length: 120
```

---

### 调试工具

#### Instruments
**用途**: 性能分析和调试
- Time Profiler: CPU 使用分析
- Allocations: 内存使用分析
- Leaks: 内存泄漏检测
- Network: 网络请求分析

---

#### Console.app
**用途**: 系统日志查看
```bash
# 过滤 AuraWind 日志
log stream --predicate 'subsystem == "com.aurawind.app"'
```

---

## 🚀 CI/CD

### GitHub Actions

**配置文件**: `.github/workflows/main.yml`

```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: macos-13
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Install SwiftLint
      run: brew install swiftlint
    
    - name: Lint
      run: swiftlint lint --strict
    
    - name: Build
      run: |
        xcodebuild -project AuraWind.xcodeproj \
                   -scheme AuraWind \
                   -configuration Debug \
                   build
    
    - name: Test
      run: |
        xcodebuild test -project AuraWind.xcodeproj \
                        -scheme AuraWind \
                        -destination 'platform=macOS'
```

---

### 发布流程

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: macos-13
    
    steps:
    - name: Build Release
      run: |
        xcodebuild -project AuraWind.xcodeproj \
                   -scheme AuraWind \
                   -configuration Release \
                   -archivePath ./build/AuraWind.xcarchive \
                   archive
    
    - name: Export Archive
      run: |
        xcodebuild -exportArchive \
                   -archivePath ./build/AuraWind.xcarchive \
                   -exportPath ./build \
                   -exportOptionsPlist ExportOptions.plist
    
    - name: Create DMG
      run: |
        create-dmg \
          --volname "AuraWind" \
          --window-pos 200 120 \
          --window-size 800 400 \
          ./build/AuraWind.dmg \
          ./build/AuraWind.app
```

---

## 📊 版本要求

### 最低版本要求

| 组件 | 最低版本 | 推荐版本 | 说明 |
|------|---------|---------|------|
| macOS | 13.0 | 14.0+ | Ventura 或更高 |
| Xcode | 15.0 | 15.2+ | 支持 Swift 5.9 |
| Swift | 5.9 | 5.9+ | 最新稳定版 |
| Git | 2.0 | 2.40+ | 版本控制 |

### 运行时要求

| 平台 | 版本 | 架构 |
|------|------|------|
| macOS | 13.0+ | Apple Silicon (M1/M2/M3) |
| macOS | 13.0+ | Intel (x86_64) |

---

## 🔄 技术栈演进

### 当前版本（v1.0）

```
Language:    Swift 5.9
UI:          SwiftUI
State:       Combine + MVVM
Storage:     UserDefaults + JSON
Hardware:    IOKit
```

### 未来计划（v2.0）

```
Storage:     CoreData 或 SwiftData
Analytics:   TelemetryDeck 或自建
Cloud:       iCloud 同步（可选）
Plugin:      插件系统支持
```

---

## 📚 技术文档资源

### 官方文档

- **Swift**: https://docs.swift.org
- **SwiftUI**: https://developer.apple.com/documentation/swiftui
- **Combine**: https://developer.apple.com/documentation/combine
- **IOKit**: https://developer.apple.com/documentation/iokit

### 学习资源

- **Swift by Sundell**: https://www.swiftbysundell.com
- **Hacking with Swift**: https://www.hackingwithswift.com
- **Point-Free**: https://www.pointfree.co
- **objc.io**: https://www.objc.io

### 社区

- **Swift Forums**: https://forums.swift.org
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/swift
- **Reddit**: r/swift, r/iOSProgramming

---

## 🔍 技术决策记录

### 为什么选择 Swift/SwiftUI？

**优势**:
- ✅ 原生性能最佳
- ✅ 与 macOS 深度集成
- ✅ 现代化的开发体验
- ✅ 强大的类型系统
- ✅ 优秀的工具链支持

**劣势**:
- ❌ 仅限 Apple 平台
- ❌ 学习曲线较陡
- ❌ SwiftUI 某些功能需要新系统

**结论**: 对于 macOS 专属应用，Swift/SwiftUI 是最佳选择。

---

### 为什么不使用 React Native / Electron？

**考虑因素**:
- 需要访问底层硬件（SMC）
- 要求原生性能
- 需要系统级别权限
- 追求最佳用户体验

**结论**: 跨平台方案无法满足需求。

---

### 为什么选择 MVVM 而不是 MVC？

**MVVM 优势**:
- 更好的关注点分离
- 便于单元测试
- 与 SwiftUI 完美配合
- 数据绑定更简洁

**结论**: MVVM 是 SwiftUI 应用的最佳架构模式。

---

## 🎓 开发者技能要求

### 必需技能

- ✅ Swift 编程语言
- ✅ SwiftUI 基础
- ✅ 基本的 Git 使用
- ✅ Xcode 开发工具

### 推荐技能

- 🔷 Combine 框架
- 🔷 单元测试
- 🔷 设计模式
- 🔷 macOS 开发经验

### 加分技能

- ⭐ IOKit 使用经验
- ⭐ 性能优化
- ⭐ UI/UX 设计
- ⭐ 技术文档写作

---

## 📞 技术支持

如有技术栈相关问题，请：
1. 查阅[开发者文档](./DeveloperDocument.md)
2. 参考[架构设计](./Architecture.md)
3. 提交 [GitHub Issue](https://github.com/yourusername/AuraWind/issues)
4. 加入开发者讨论群

---

**技术栈版本**: 1.0.0  
**最后更新**: 2025-11-16 21:16
**维护者**: AuraWind Tech Team