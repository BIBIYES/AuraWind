# AuraWind 开发者文档

## 📋 项目概述

AuraWind 是一款现代化的 macOS 风扇控制软件，采用 Swift 和 SwiftUI 原生技术栈开发。软件提供直观优雅的用户界面和强大的风扇管理功能，采用苹果液态玻璃（Liquid Glass）设计风格，为用户带来极致的视觉体验。

### 核心特性

- **多风扇控制**：支持同时管理多个风扇设备
- **温度监控**：实时监控 CPU/GPU 等硬件温度并提供可视化图表
- **自定义曲线**：灵活配置温度-转速曲线
- **液态玻璃 UI**：现代化的 Liquid Glass 设计风格
- **系统托盘集成**：轻量级后台运行，快速访问
- **设置面板**：独立窗口提供详细配置选项
- **性能优化**：低资源占用，高效运行

### 目标用户

- 游戏玩家
- 内容创作者
- 超频爱好者
- 对电脑散热有精细控制需求的用户

---

## 🏗️ 技术架构

### 架构模式

AuraWind 采用 **MVVM (Model-View-ViewModel)** 架构模式，结合 SwiftUI 的声明式编程范式和 Combine 框架的响应式编程特性。

```
┌─────────────────────────────────────────────────────────┐
│                      Presentation Layer                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Main View   │  │  Settings    │  │  Menu Bar    │  │
│  │              │  │  View        │  │  View        │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────┐
│                      ViewModel Layer                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Fan        │  │ Temperature  │  │  Settings    │  │
│  │ ViewModel    │  │  ViewModel   │  │  ViewModel   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────┐
│                       Model Layer                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Fan        │  │ Temperature  │  │   Curve      │  │
│  │   Model      │  │   Sensor     │  │   Config     │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────┐
│                      Service Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   SMC        │  │  Persistence │  │  Analytics   │  │
│  │  Service     │  │   Service    │  │   Service    │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────┐
│                      Hardware Layer                      │
│                   (SMC Driver Interface)                 │
└─────────────────────────────────────────────────────────┘
```

### 层次说明

#### 1. Presentation Layer（展示层）
- **职责**：UI 渲染和用户交互
- **技术**：SwiftUI Views, Modifiers
- **组件**：
  - `MainView`: 主窗口界面
  - `SettingsView`: 设置面板
  - `MenuBarView`: 菜单栏视图
  - `ChartView`: 温度/转速图表

#### 2. ViewModel Layer（视图模型层）
- **职责**：业务逻辑和状态管理
- **技术**：ObservableObject, @Published, Combine
- **组件**：
  - `FanControlViewModel`: 风扇控制逻辑
  - `TemperatureMonitorViewModel`: 温度监控逻辑
  - `SettingsViewModel`: 设置管理逻辑

#### 3. Model Layer（模型层）
- **职责**：数据模型和业务实体
- **技术**：Struct, Class, Codable
- **组件**：
  - `Fan`: 风扇实体
  - `TemperatureSensor`: 温度传感器
  - `CurveProfile`: 温度曲线配置
  - `AppSettings`: 应用设置

#### 4. Service Layer（服务层）
- **职责**：底层服务和数据持久化
- **技术**：Singleton Pattern, Protocol-oriented
- **组件**：
  - `SMCService`: SMC 驱动交互
  - `PersistenceService`: 数据持久化
  - `AnalyticsService`: 数据分析
  - `NotificationService`: 通知服务

#### 5. Hardware Layer（硬件层）
- **职责**：与 macOS SMC 驱动通信
- **技术**：IOKit Framework
- **功能**：读取温度、控制风扇转速

---

## 📁 项目结构

```
AuraWind/
├── AuraWind/
│   ├── App/
│   │   ├── AuraWindApp.swift          # 应用入口
│   │   ├── AppDelegate.swift          # 应用代理
│   │   └── SceneDelegate.swift        # 场景代理
│   │
│   ├── Views/                         # 视图层
│   │   ├── Main/
│   │   │   ├── MainView.swift         # 主视图
│   │   │   ├── DashboardView.swift    # 仪表盘
│   │   │   └── FanListView.swift      # 风扇列表
│   │   ├── Settings/
│   │   │   ├── SettingsView.swift     # 设置视图
│   │   │   ├── GeneralSettings.swift  # 通用设置
│   │   │   └── CurveEditor.swift      # 曲线编辑器
│   │   ├── MenuBar/
│   │   │   ├── MenuBarView.swift      # 菜单栏视图
│   │   │   └── QuickActions.swift     # 快捷操作
│   │   └── Components/                # 可复用组件
│   │       ├── LiquidGlassCard.swift  # 液态玻璃卡片
│   │       ├── GlassButton.swift      # 玻璃按钮
│   │       ├── TemperatureChart.swift # 温度图表
│   │       └── FanSpeedSlider.swift   # 转速滑块
│   │
│   ├── ViewModels/                    # 视图模型层
│   │   ├── FanControlViewModel.swift
│   │   ├── TemperatureMonitorViewModel.swift
│   │   ├── SettingsViewModel.swift
│   │   └── MenuBarViewModel.swift
│   │
│   ├── Models/                        # 模型层
│   │   ├── Fan.swift                  # 风扇模型
│   │   ├── TemperatureSensor.swift    # 温度传感器
│   │   ├── CurveProfile.swift         # 曲线配置
│   │   ├── AppSettings.swift          # 应用设置
│   │   └── ChartDataPoint.swift       # 图表数据点
│   │
│   ├── Services/                      # 服务层
│   │   ├── SMCService.swift           # SMC 驱动服务
│   │   ├── PersistenceService.swift   # 持久化服务
│   │   ├── AnalyticsService.swift     # 分析服务
│   │   ├── NotificationService.swift  # 通知服务
│   │   └── UpdateService.swift        # 更新服务
│   │
│   ├── Utils/                         # 工具类
│   │   ├── Extensions/
│   │   │   ├── Color+Theme.swift      # 颜色主题扩展
│   │   │   ├── View+Modifiers.swift   # 视图修饰器
│   │   │   └── Double+Format.swift    # 数值格式化
│   │   ├── Constants.swift            # 常量定义
│   │   └── Logger.swift               # 日志工具
│   │
│   ├── Resources/                     # 资源文件
│   │   ├── Assets.xcassets/
│   │   ├── Localizable.strings        # 本地化字符串
│   │   └── Info.plist
│   │
│   └── Supporting Files/
│       └── Entitlements.plist         # 权限配置
│
├── AuraWindTests/                     # 单元测试
│   ├── ViewModelTests/
│   ├── ServiceTests/
│   └── ModelTests/
│
├── AuraWindUITests/                   # UI 测试
│
└── docs/                              # 项目文档
    ├── Architecture.md
    ├── APIReference.md
    └── UIDesignGuide.md
```

---

## 🔧 核心模块设计

### 1. SMC Service (System Management Controller)

#### 职责
- 与 macOS SMC 驱动通信
- 读取温度传感器数据
- 控制风扇转速
- 监控硬件状态

#### 核心接口
```swift
protocol SMCServiceProtocol {
    // 温度监控
    func readTemperature(sensor: TemperatureSensorType) async throws -> Double
    func getAllTemperatures() async throws -> [TemperatureSensor]
    
    // 风扇控制
    func getFanCount() async throws -> Int
    func getFanInfo(index: Int) async throws -> FanInfo
    func setFanSpeed(index: Int, rpm: Int) async throws
    func setFanAutoMode(index: Int) async throws
    func getFanCurrentSpeed(index: Int) async throws -> Int
    
    // 硬件监控
    func getCPUUsage() async throws -> Double
    func getGPUUsage() async throws -> Double
}
```

#### 实现要点
- 使用 IOKit 框架访问 SMC
- 实现线程安全的 SMC 读写
- 错误处理和重试机制
- 缓存机制减少 SMC 访问频率

### 2. Fan Control ViewModel

#### 职责
- 管理风扇状态
- 执行温度-转速曲线算法
- 处理用户控制指令
- 发布状态更新

#### 核心属性
```swift
@MainActor
class FanControlViewModel: ObservableObject {
    @Published var fans: [Fan] = []
    @Published var currentMode: FanMode = .auto
    @Published var activeCurveProfile: CurveProfile?
    @Published var isMonitoring: Bool = false
    
    private let smcService: SMCServiceProtocol
    private let persistenceService: PersistenceServiceProtocol
    private var monitoringTask: Task<Void, Never>?
    
    // 核心方法
    func startMonitoring() async
    func stopMonitoring()
    func setFanSpeed(fanIndex: Int, speed: Int) async
    func applyProfile(_ profile: CurveProfile) async
    func resetToAuto() async
}
```

### 3. Temperature Monitor ViewModel

#### 职责
- 实时监控温度
- 收集历史数据
- 生成图表数据
- 触发警告通知

#### 核心功能
```swift
@MainActor
class TemperatureMonitorViewModel: ObservableObject {
    @Published var sensors: [TemperatureSensor] = []
    @Published var chartData: [ChartDataPoint] = []
    @Published var warningThreshold: Double = 85.0
    
    func startMonitoring(interval: TimeInterval)
    func stopMonitoring()
    func getHistoricalData(duration: TimeInterval) -> [ChartDataPoint]
    func exportData() async throws -> URL
}
```

### 4. Curve Profile System

#### 曲线配置模型
```swift
struct CurveProfile: Codable, Identifiable {
    let id: UUID
    var name: String
    var points: [CurvePoint]
    var isActive: Bool
    
    struct CurvePoint: Codable {
        var temperature: Double  // 温度 (°C)
        var fanSpeed: Int        // 转速 (RPM)
    }
    
    // 插值算法
    func interpolateFanSpeed(for temperature: Double) -> Int
}
```

#### 曲线算法
- 使用线性插值计算中间点转速
- 支持自定义曲线点数（2-10个点）
- 平滑过渡避免频繁转速变化
- 预设模式：静音、平衡、性能、自定义

---

## 🎨 UI 设计实现

### 液态玻璃效果

#### 核心组件
```swift
struct LiquidGlassCard<Content: View>: View {
    let content: Content
    var blurRadius: CGFloat = 20
    var opacity: Double = 0.3
    
    var body: some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.1),
                                Color.purple.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blur(radius: blurRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.3),
                                .white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}
```

### 配色方案

#### 主题色
```swift
extension Color {
    static let auraBlue = Color(red: 0.4, green: 0.7, blue: 1.0)
    static let auraYellow = Color(red: 1.0, green: 0.9, blue: 0.4)
    static let auraPurple = Color(red: 0.7, green: 0.4, blue: 1.0)
    
    static let glassBackground = Color.white.opacity(0.1)
    static let glassBorder = Color.white.opacity(0.2)
}
```

### 动画效果

#### 平滑过渡
```swift
struct AnimatedFanSpeed: View {
    @State private var rotation: Double = 0
    let speed: Int
    
    var body: some View {
        Image(systemName: "fan.fill")
            .rotationEffect(.degrees(rotation))
            .animation(.linear(duration: 60.0 / Double(max(speed, 1))).repeatForever(autoreverses: false), value: rotation)
            .onAppear {
                rotation = 360
            }
    }
}
```

---

## 🔌 关键接口

### 1. SMC 驱动接口

#### IOKit 集成
```swift
class SMCService {
    private var connection: io_connect_t = 0
    
    // 打开 SMC 连接
    func openSMC() throws {
        let service = IOServiceGetMatchingService(
            kIOMainPortDefault,
            IOServiceMatching("AppleSMC")
        )
        guard service != 0 else {
            throw SMCError.serviceNotFound
        }
        
        let result = IOServiceOpen(service, mach_task_self_, 0, &connection)
        guard result == kIOReturnSuccess else {
            throw SMCError.connectionFailed
        }
    }
    
    // 读取 SMC 键值
    func readKey(_ key: String) throws -> SMCData {
        // 实现 SMC 键值读取
    }
    
    // 写入 SMC 键值
    func writeKey(_ key: String, data: SMCData) throws {
        // 实现 SMC 键值写入
    }
}
```

### 2. 数据持久化接口

#### UserDefaults + JSON
```swift
protocol PersistenceServiceProtocol {
    func save<T: Codable>(_ object: T, forKey key: String) throws
    func load<T: Codable>(_ type: T.Type, forKey key: String) throws -> T?
    func delete(forKey key: String)
}

class PersistenceService: PersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        userDefaults.set(data, forKey: key)
    }
    
    func load<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
```

---

## 🚀 实现要点

### 1. 性能优化

#### 异步操作
- 所有 SMC 操作使用 async/await
- 避免阻塞主线程
- 使用 Task 管理后台任务

```swift
func updateFanSpeeds() async {
    await withTaskGroup(of: Void.self) { group in
        for (index, fan) in fans.enumerated() {
            group.addTask {
                if let speed = try? await self.smcService.getFanCurrentSpeed(index: index) {
                    await MainActor.run {
                        self.fans[index].currentSpeed = speed
                    }
                }
            }
        }
    }
}
```

#### 数据缓存
- 温度数据缓存 1 秒
- 风扇信息缓存 5 秒
- 减少 SMC 访问频率

### 2. 错误处理

#### 统一错误类型
```swift
enum AuraWindError: LocalizedError {
    case smcAccessDenied
    case fanNotFound
    case invalidSpeed
    case temperatureSensorFailed
    
    var errorDescription: String? {
        switch self {
        case .smcAccessDenied:
            return "无法访问 SMC，请检查权限设置"
        case .fanNotFound:
            return "未找到风扇设备"
        case .invalidSpeed:
            return "无效的转速值"
        case .temperatureSensorFailed:
            return "温度传感器读取失败"
        }
    }
}
```

### 3. 权限管理

#### Required Entitlements
```xml
<key>com.apple.security.app-sandbox</key>
<true/>
<key>com.apple.security.device.usb</key>
<true/>
<key>com.apple.security.iokit-user-client-class</key>
<array>
    <string>AppleSMC</string>
</array>
```

### 4. 日志记录

#### 统一日志系统
```swift
import OSLog

extension Logger {
    static let smc = Logger(subsystem: "com.aurawind.app", category: "SMC")
    static let fan = Logger(subsystem: "com.aurawind.app", category: "Fan")
    static let temp = Logger(subsystem: "com.aurawind.app", category: "Temperature")
}

// 使用示例
Logger.fan.info("Fan speed updated: \(speed) RPM")
Logger.smc.error("SMC access failed: \(error.localizedDescription)")
```

### 5. 测试策略

#### 单元测试
- ViewModel 逻辑测试
- Service 层 Mock 测试
- 数据模型验证

```swift
@testable import AuraWind
import XCTest

class FanControlViewModelTests: XCTestCase {
    var viewModel: FanControlViewModel!
    var mockSMCService: MockSMCService!
    
    override func setUp() {
        super.setUp()
        mockSMCService = MockSMCService()
        viewModel = FanControlViewModel(smcService: mockSMCService)
    }
    
    func testSetFanSpeed() async throws {
        await viewModel.setFanSpeed(fanIndex: 0, speed: 3000)
        XCTAssertEqual(mockSMCService.lastSetSpeed, 3000)
    }
}
```

---

## 📦 依赖管理

### Swift Package Manager

#### Package.swift
```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AuraWind",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 图表库
        .package(url: "https://github.com/danielgindi/Charts.git", from: "5.0.0"),
        // 用户偏好存储
        .package(url: "https://github.com/sindresorhus/Defaults", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "AuraWind",
            dependencies: ["Charts", "Defaults"]
        )
    ]
)
```

---

## 🔐 安全性考虑

### 1. 权限最小化
- 仅请求必需的系统权限
- 明确说明权限用途
- 沙箱环境运行

### 2. 数据隐私
- 本地数据存储
- 不收集用户隐私信息
- 可选的匿名使用统计

### 3. 安全编码
- 输入验证
- 边界检查
- 资源限制

---

## 📚 参考资料

### 官方文档
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [IOKit Framework](https://developer.apple.com/documentation/iokit)
- [Combine Framework](https://developer.apple.com/documentation/combine)

### 社区资源
- [SMC Driver Specification](https://github.com/acidanthera/VirtualSMC)
- [macOS Fan Control Best Practices](https://github.com/crystalidea/macs-fan-control)

---

**版本**: 1.0.0  
**最后更新**: 2025-11-16  21:04
**维护者**: AuraWind Development Team