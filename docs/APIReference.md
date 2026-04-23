# AuraWind API 参考文档

本文档详细描述 AuraWind 的核心 API 接口，包括服务层、ViewModel 层的公共接口。

---

## 📚 目录

1. [SMC Service API](#smc-service-api)
2. [Persistence Service API](#persistence-service-api)
3. [Notification Service API](#notification-service-api)
4. [ViewModel API](#viewmodel-api)
5. [数据模型](#数据模型)
6. [错误处理](#错误处理)

---

## 🔌 SMC Service API

### SMCServiceProtocol

主要负责与 macOS SMC (System Management Controller) 交互的服务接口。

#### 初始化

```swift
protocol SMCServiceProtocol {
    func configure(with configuration: SMCConfiguration) throws
    func start() async throws
    func stop() async
}
```

**配置示例**:
```swift
let config = SMCConfiguration(
    cacheTimeout: 1.0,
    retryCount: 3,
    retryDelay: 0.5
)
try await smcService.configure(with: config)
try await smcService.start()
```

---

### 温度监控 API

#### readTemperature

读取指定传感器的温度值。

```swift
func readTemperature(sensor: TemperatureSensorType) async throws -> Double
```

**参数**:
- `sensor`: `TemperatureSensorType` - 传感器类型

**返回值**:
- `Double` - 温度值（摄氏度）

**抛出异常**:
- `SMCError.notConnected` - SMC 未连接
- `SMCError.readFailed` - 读取失败
- `SMCError.invalidSensor` - 无效的传感器

**使用示例**:
```swift
do {
    let cpuTemp = try await smcService.readTemperature(sensor: .cpu)
    print("CPU 温度: \(cpuTemp)°C")
} catch {
    print("读取温度失败: \(error)")
}
```

---

#### getAllTemperatures

获取所有可用传感器的温度数据。

```swift
func getAllTemperatures() async throws -> [TemperatureSensor]
```

**返回值**:
- `[TemperatureSensor]` - 温度传感器数组

**使用示例**:
```swift
let sensors = try await smcService.getAllTemperatures()
for sensor in sensors {
    print("\(sensor.name): \(sensor.currentTemperature)°C")
}
```

---

### 风扇控制 API

#### getFanCount

获取系统风扇数量。

```swift
func getFanCount() async throws -> Int
```

**返回值**:
- `Int` - 风扇数量

**使用示例**:
```swift
let fanCount = try await smcService.getFanCount()
print("系统有 \(fanCount) 个风扇")
```

---

#### getFanInfo

获取指定风扇的详细信息。

```swift
func getFanInfo(index: Int) async throws -> FanInfo
```

**参数**:
- `index`: `Int` - 风扇索引（从 0 开始）

**返回值**:
- `FanInfo` - 风扇信息结构体

```swift
struct FanInfo {
    let index: Int
    let name: String
    let currentSpeed: Int    // RPM
    let minSpeed: Int        // RPM
    let maxSpeed: Int        // RPM
    let targetSpeed: Int     // RPM
    let isManualMode: Bool
}
```

**使用示例**:
```swift
let fanInfo = try await smcService.getFanInfo(index: 0)
print("风扇: \(fanInfo.name)")
print("当前转速: \(fanInfo.currentSpeed) RPM")
print("转速范围: \(fanInfo.minSpeed)-\(fanInfo.maxSpeed) RPM")
```

---

#### setFanSpeed

设置指定风扇的目标转速。

```swift
func setFanSpeed(index: Int, rpm: Int) async throws
```

**参数**:
- `index`: `Int` - 风扇索引
- `rpm`: `Int` - 目标转速（RPM）

**抛出异常**:
- `SMCError.invalidSpeed` - 转速超出范围
- `SMCError.writeFailed` - 写入失败

**使用示例**:
```swift
do {
    try await smcService.setFanSpeed(index: 0, rpm: 3000)
    print("风扇转速已设置为 3000 RPM")
} catch SMCError.invalidSpeed(let speed) {
    print("无效的转速: \(speed)")
}
```

---

#### setFanAutoMode

将风扇恢复为自动模式。

```swift
func setFanAutoMode(index: Int) async throws
```

**参数**:
- `index`: `Int` - 风扇索引

**使用示例**:
```swift
try await smcService.setFanAutoMode(index: 0)
print("风扇已切换为自动模式")
```

---

#### getFanCurrentSpeed

获取风扇当前实际转速。

```swift
func getFanCurrentSpeed(index: Int) async throws -> Int
```

**参数**:
- `index`: `Int` - 风扇索引

**返回值**:
- `Int` - 当前转速（RPM）

**使用示例**:
```swift
let currentSpeed = try await smcService.getFanCurrentSpeed(index: 0)
print("当前转速: \(currentSpeed) RPM")
```

---

### 硬件监控 API

#### getCPUUsage

获取 CPU 使用率。

```swift
func getCPUUsage() async throws -> Double
```

**返回值**:
- `Double` - CPU 使用率（0-100）

---

#### getGPUUsage

获取 GPU 使用率。

```swift
func getGPUUsage() async throws -> Double
```

**返回值**:
- `Double` - GPU 使用率（0-100）

---

## 💾 Persistence Service API

### PersistenceServiceProtocol

数据持久化服务接口。

#### save

保存对象到 UserDefaults。

```swift
func save<T: Codable>(_ object: T, forKey key: String) throws
```

**参数**:
- `object`: `T` - 要保存的对象（必须遵循 Codable）
- `key`: `String` - 存储键

**使用示例**:
```swift
let settings = AppSettings(...)
try persistenceService.save(settings, forKey: "app_settings")
```

---

#### load

从 UserDefaults 加载对象。

```swift
func load<T: Codable>(_ type: T.Type, forKey key: String) throws -> T?
```

**参数**:
- `type`: `T.Type` - 对象类型
- `key`: `String` - 存储键

**返回值**:
- `T?` - 加载的对象，如果不存在则返回 nil

**使用示例**:
```swift
if let settings = try persistenceService.load(AppSettings.self, forKey: "app_settings") {
    print("加载设置成功")
}
```

---

#### delete

删除指定键的数据。

```swift
func delete(forKey key: String)
```

**参数**:
- `key`: `String` - 存储键

---

#### saveToFile

保存对象到文件。

```swift
func saveToFile<T: Codable>(_ object: T, filename: String) throws
```

**参数**:
- `object`: `T` - 要保存的对象
- `filename`: `String` - 文件名

**使用示例**:
```swift
let profile = CurveProfile(...)
try persistenceService.saveToFile(profile, filename: "custom_profile.json")
```

---

#### loadFromFile

从文件加载对象。

```swift
func loadFromFile<T: Codable>(_ type: T.Type, filename: String) throws -> T?
```

**参数**:
- `type`: `T.Type` - 对象类型
- `filename`: `String` - 文件名

**返回值**:
- `T?` - 加载的对象

---

## 🔔 Notification Service API

### NotificationServiceProtocol

系统通知服务接口。

#### requestAuthorization

请求通知权限。

```swift
func requestAuthorization() async throws -> Bool
```

**返回值**:
- `Bool` - 是否授权成功

---

#### sendNotification

发送通知。

```swift
func sendNotification(
    title: String,
    body: String,
    category: NotificationCategory,
    userInfo: [AnyHashable: Any]?
) async throws
```

**参数**:
- `title`: `String` - 通知标题
- `body`: `String` - 通知内容
- `category`: `NotificationCategory` - 通知分类
- `userInfo`: `[AnyHashable: Any]?` - 附加信息（可选）

**通知分类**:
```swift
enum NotificationCategory: String {
    case temperature = "TEMPERATURE"
    case fan = "FAN"
    case system = "SYSTEM"
}
```

**使用示例**:
```swift
try await notificationService.sendNotification(
    title: "温度警告",
    body: "CPU 温度过高: 85°C",
    category: .temperature,
    userInfo: ["temperature": 85.0]
)
```

---

#### scheduleNotification

调度延迟通知。

```swift
func scheduleNotification(
    title: String,
    body: String,
    delay: TimeInterval,
    category: NotificationCategory
) async throws
```

**参数**:
- `title`: `String` - 通知标题
- `body`: `String` - 通知内容
- `delay`: `TimeInterval` - 延迟时间（秒）
- `category`: `NotificationCategory` - 通知分类

---

## 🎛️ ViewModel API

### FanControlViewModel

风扇控制视图模型。

#### 属性

```swift
@Published private(set) var fans: [Fan]
@Published private(set) var isMonitoring: Bool
@Published private(set) var currentMode: FanMode
@Published private(set) var error: AuraWindError?
```

#### 方法

##### startMonitoring

开始监控风扇。

```swift
func startMonitoring() async
```

**使用示例**:
```swift
await viewModel.startMonitoring()
```

---

##### stopMonitoring

停止监控风扇。

```swift
func stopMonitoring()
```

---

##### setFanSpeed

设置风扇转速。

```swift
func setFanSpeed(fanIndex: Int, speed: Int) async
```

**参数**:
- `fanIndex`: `Int` - 风扇索引
- `speed`: `Int` - 目标转速（RPM）

---

##### applyProfile

应用曲线配置。

```swift
func applyProfile(_ profile: CurveProfile) async
```

**参数**:
- `profile`: `CurveProfile` - 曲线配置

---

##### resetToAuto

重置所有风扇为自动模式。

```swift
func resetToAuto() async
```

---

### TemperatureMonitorViewModel

温度监控视图模型。

#### 属性

```swift
@Published private(set) var sensors: [TemperatureSensor]
@Published private(set) var chartData: [ChartDataPoint]
@Published var warningThreshold: Double
```

#### 方法

##### startMonitoring

开始温度监控。

```swift
func startMonitoring(interval: TimeInterval = 1.0)
```

**参数**:
- `interval`: `TimeInterval` - 更新间隔（秒），默认 1.0

---

##### stopMonitoring

停止温度监控。

```swift
func stopMonitoring()
```

---

##### getHistoricalData

获取历史温度数据。

```swift
func getHistoricalData(duration: TimeInterval) -> [ChartDataPoint]
```

**参数**:
- `duration`: `TimeInterval` - 时间范围（秒）

**返回值**:
- `[ChartDataPoint]` - 图表数据点数组

---

##### exportData

导出温度数据。

```swift
func exportData() async throws -> URL
```

**返回值**:
- `URL` - 导出文件的 URL

---

### SettingsViewModel

设置视图模型。

#### 属性

```swift
@Published var settings: AppSettings
@Published var profiles: [CurveProfile]
@Published var selectedProfile: CurveProfile?
```

#### 方法

##### saveSettings

保存设置。

```swift
func saveSettings() async throws
```

---

##### loadSettings

加载设置。

```swift
func loadSettings() async throws
```

---

##### createProfile

创建新的曲线配置。

```swift
func createProfile(name: String, points: [CurveProfile.CurvePoint]) async throws -> CurveProfile
```

**参数**:
- `name`: `String` - 配置名称
- `points`: `[CurveProfile.CurvePoint]` - 曲线点数组

**返回值**:
- `CurveProfile` - 创建的配置

---

##### updateProfile

更新曲线配置。

```swift
func updateProfile(_ profile: CurveProfile) async throws
```

---

##### deleteProfile

删除曲线配置。

```swift
func deleteProfile(_ profile: CurveProfile) async throws
```

---

## 📊 数据模型

### Fan

风扇数据模型。

```swift
struct Fan: Identifiable, Codable {
    let id: UUID
    var index: Int
    var name: String
    var currentSpeed: Int
    var minSpeed: Int
    var maxSpeed: Int
    var isManualControl: Bool
    
    func speedPercentage() -> Double
    func isSpeedInRange(_ speed: Int) -> Bool
}
```

---

### TemperatureSensor

温度传感器模型。

```swift
struct TemperatureSensor: Identifiable, Codable {
    let id: UUID
    var type: SensorType
    var name: String
    var currentTemperature: Double
    var maxTemperature: Double
    var readings: [TemperatureReading]
    
    enum SensorType: String, Codable {
        case cpu, gpu, ambient, proximity
    }
    
    func temperaturePercentage() -> Double
    func isWarning() -> Bool
}
```

---

### CurveProfile

温度-转速曲线配置。

```swift
struct CurveProfile: Identifiable, Codable {
    let id: UUID
    var name: String
    var points: [CurvePoint]
    var isActive: Bool
    var createdAt: Date
    var updatedAt: Date
    
    struct CurvePoint: Codable {
        var temperature: Double  // °C
        var fanSpeed: Int        // RPM
    }
    
    func interpolateFanSpeed(for temperature: Double) -> Int
    func validate() -> Result<Void, CurveValidationError>
}
```

---

### AppSettings

应用设置模型。

```swift
struct AppSettings: Codable {
    var launchAtLogin: Bool
    var showMenuBarIcon: Bool
    var updateInterval: TimeInterval
    var temperatureUnit: TemperatureUnit
    var notificationsEnabled: Bool
    var warningThreshold: Double
    var theme: AppTheme
    
    enum TemperatureUnit: String, Codable {
        case celsius, fahrenheit
    }
    
    enum AppTheme: String, Codable {
        case system, light, dark
    }
}
```

---

## ⚠️ 错误处理

### AuraWindError

应用错误枚举。

```swift
enum AuraWindError: LocalizedError {
    case smcAccessDenied
    case fanNotFound(index: Int)
    case invalidSpeed(Int)
    case temperatureSensorFailed
    case persistenceError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .smcAccessDenied:
            return "无法访问 SMC，请检查权限设置"
        case .fanNotFound(let index):
            return "未找到索引为 \(index) 的风扇"
        case .invalidSpeed(let speed):
            return "无效的转速值: \(speed) RPM"
        case .temperatureSensorFailed:
            return "温度传感器读取失败"
        case .persistenceError(let error):
            return "数据存储错误: \(error.localizedDescription)"
        case .networkError(let error):
            return "网络错误: \(error.localizedDescription)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .smcAccessDenied:
            return "请在系统设置中允许应用访问系统管理控制器"
        case .fanNotFound:
            return "请重启应用或检查硬件连接"
        case .invalidSpeed:
            return "请输入有效的转速值"
        case .temperatureSensorFailed:
            return "请检查传感器连接或重启应用"
        case .persistenceError:
            return "请检查存储权限或清理应用数据"
        case .networkError:
            return "请检查网络连接"
        }
    }
}
```

---

### SMCError

SMC 特定错误。

```swift
enum SMCError: LocalizedError {
    case notConnected
    case serviceNotFound
    case connectionFailed
    case readFailed
    case writeFailed
    case invalidKey
    case invalidSensor
    case invalidSpeed(Int)
    case timeout
    
    var errorDescription: String? { /* ... */ }
}
```

---

## 🔧 使用示例

### 完整示例：监控温度并控制风扇

```swift
class FanController {
    private let smcService: SMCServiceProtocol
    private let notificationService: NotificationServiceProtocol
    
    init(
        smcService: SMCServiceProtocol,
        notificationService: NotificationServiceProtocol
    ) {
        self.smcService = smcService
        self.notificationService = notificationService
    }
    
    func startMonitoring() async {
        do {
            // 启动 SMC 服务
            try await smcService.start()
            
            // 监控循环
            while true {
                // 读取温度
                let cpuTemp = try await smcService.readTemperature(sensor: .cpu)
                
                // 检查是否需要警告
                if cpuTemp > 85.0 {
                    try await notificationService.sendNotification(
                        title: "温度警告",
                        body: "CPU 温度: \(cpuTemp)°C",
                        category: .temperature,
                        userInfo: nil
                    )
                }
                
                // 根据温度调整风扇
                let targetSpeed = calculateFanSpeed(for: cpuTemp)
                try await smcService.setFanSpeed(index: 0, rpm: targetSpeed)
                
                // 等待下次更新
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1秒
            }
        } catch {
            print("监控错误: \(error)")
        }
    }
    
    private func calculateFanSpeed(for temperature: Double) -> Int {
        // 简单的线性映射
        let minTemp = 40.0
        let maxTemp = 90.0
        let minSpeed = 1200
        let maxSpeed = 6000
        
        let normalized = (temperature - minTemp) / (maxTemp - minTemp)
        let speed = minSpeed + Int(normalized * Double(maxSpeed - minSpeed))
        
        return max(minSpeed, min(maxSpeed, speed))
    }
}
```

---

## 📝 最佳实践

### 1. 错误处理

```swift
// ✅ 推荐
do {
    try await smcService.setFanSpeed(index: 0, rpm: 3000)
} catch SMCError.invalidSpeed(let speed) {
    print("转速 \(speed) 超出范围")
} catch SMCError.notConnected {
    print("SMC 未连接，尝试重新连接...")
    try? await smcService.start()
} catch {
    print("未知错误: \(error)")
}

// ❌ 不推荐
try? await smcService.setFanSpeed(index: 0, rpm: 3000)
```

### 2. 资源管理

```swift
// ✅ 推荐
class MyViewController {
    private var monitoringTask: Task<Void, Never>?
    
    func startMonitoring() {
        monitoringTask = Task {
            await performMonitoring()
        }
    }
    
    func stopMonitoring() {
        monitoringTask?.cancel()
        monitoringTask = nil
    }
    
    deinit {
        stopMonitoring()
    }
}
```

### 3. 并发处理

```swift
// ✅ 推荐 - 使用 TaskGroup
func updateAllFans() async {
    await withTaskGroup(of: Void.self) { group in
        for (index, fan) in fans.enumerated() {
            group.addTask {
                try? await self.updateFan(at: index)
            }
        }
    }
}

// ❌ 不推荐 - 顺序执行
func updateAllFans() async {
    for (index, _) in fans.enumerated() {
        try? await updateFan(at: index)
    }
}
```

---

## 🔄 版本兼容性

| API | 最低版本 | 说明 |
|-----|---------|------|
| SMCServiceProtocol | 1.0.0 | 核心 SMC 接口 |
| async/await | 1.0.0 | 要求 macOS 13.0+ |
| Combine | 1.0.0 | 响应式编程支持 |

---

## 📞 技术支持

如有 API 相关问题，请：
1. 查看示例代码
2. 参考开发者文档
3. 提交 GitHub Issue
4. 联系技术支持

---

**API 版本**: 1.0.0  
**最后更新**: 2025-11-16  21:12
**维护者**: AuraWind API Team