# AuraWind

AuraWind 是一个面向 macOS 的本机风扇控制与温度监控工具，目标是：

- 在本机可控地调节风扇转速
- 稳定读取硬件温度并可视化趋势
- 通过特权 Helper 完成系统级 SMC 访问
- 以 SwiftUI + MVVM 方式保持可维护性

## 功能概览

- 风扇模式：手动 / 静音 / 平衡 / 性能
- 实时温度监控与历史趋势图
- 风扇转速趋势图与时间范围筛选
- 数据导出（CSV）
- 菜单栏快捷控制
- 本机打包与安装脚本（包含 Helper 安装）

## 项目架构

### 1) 分层设计

- `Views/`：SwiftUI 视图层（仪表盘、温度页、风扇页、设置页）
- `ViewModels/`：状态管理与业务编排（MVVM）
- `Services/`：SMC、Helper、导出、持久化等基础能力
- `Models/`：风扇、温度、图表点、标注等数据模型
- `SMCHelper/`：以 root 权限运行的 XPC Helper，可执行 SMC 读写

### 2) 运行链路

1. App 启动后初始化 `SMCServiceWithHelper`
2. 主进程通过 `HelperToolManager` 建立 XPC 连接
3. Helper 执行底层 SMC 访问并返回温度/风扇数据
4. ViewModel 进行模式控制、缓存、降采样与图表数据组织
5. SwiftUI 页面实时渲染与交互

### 3) 核心模块

- `SMCServiceWithHelper`：统一温度/风扇访问入口，含缓存与连接去重
- `FanControlViewModel`：风扇模式切换、曲线插值与目标转速控制
- `TemperatureMonitorViewModel`：温度采集、过滤、图表降采样与导出
- `ChartExportService`：图表数据导出（当前稳定格式为 CSV）

## 制作思路

### 1) 为什么使用 Helper Tool

macOS 对 SMC 写入权限严格限制。为了在本机可用场景下稳定控制风扇，采用了：

- 主 App（普通权限）负责 UI 与业务逻辑
- Helper（系统安装）负责特权操作
- XPC 作为边界，隔离权限与业务代码

这样能兼顾可用性和可维护性，且不依赖给他人分发所需的完整签名/公证流程。

### 2) 图标与品牌资源

- 设计源文件位于 `AuraWind/icon/`
- App 图标输入源：`AuraWind/icon/logo.png`
- Dock 视觉尺寸优化源：`AuraWind/icon/logo_appicon_source.png`（在 1024 画布内保留留白，避免看起来比系统图标更大）
- 最终尺寸输出到 `Assets.xcassets/AppIcon.appiconset`

### 3) 性能与稳定性策略

- 温度数据二次过滤（剔除无效 0°C/异常值）
- 图表显示降采样，避免长时间运行卡顿
- 自动标注节流与数量上限，避免内存持续增长
- 启动连接任务去重，减少并发初始化抖动

## 技术难点（重点）

### 1) Helper Tool 配置与权限链路（最关键）

难点：

- SMC 写入不在普通 App 权限范围内，直接在主进程里做会失败或不稳定
- Helper 需要运行在系统目录，且由 `launchd` 托管
- 主进程与特权进程之间要做严格的协议边界，避免 UI 层耦合到系统权限逻辑

项目做法：

- 主进程通过 `HelperToolManager` 统一管理安装状态、XPC 连接和重连
- Helper 实际安装路径：`/Library/PrivilegedHelperTools/com.aurawind.AuraWind.SMCHelper`
- LaunchDaemon 配置路径：`/Library/LaunchDaemons/com.aurawind.AuraWind.SMCHelper.plist`
- 使用 `./打包并安装.sh` 执行本机安装流程，避免开发阶段依赖完整开发者分发签名链

### 2) XPC 通信稳定性与错误收敛

难点：

- XPC 在服务重启、系统切换或异常退出时会中断
- 如果 UI 侧直接感知原始错误，体验会出现大量抖动

项目做法：

- 在 `HelperToolManager` 中统一处理中断/失效回调
- 使用连接前可用性探测（如版本请求）判断 Helper 是否真正可用
- 将连接失败归一成可操作错误（例如提示先运行安装脚本）

### 3) 温度采集可用性（0°C 与无效传感器）

难点：

- 不同机型的 SMC 键集合不同，部分键会长期返回 0 或异常值
- Apple Silicon 与 Intel 上可用温度键并不一致

项目做法：

- Helper 先扫描候选键，再按“合理温度区间”过滤
- 服务层对全量温度读取做短期缓存与并发去重，降低重复扫描成本
- UI 侧仅展示有效传感器，避免 0°C 污染图表

### 4) 风扇控制策略与模式映射

难点：

- “模式”是产品语义，最终要映射为每个风扇的目标转速
- 多风扇设备需要保持策略一致，避免风扇间行为割裂

项目做法：

- 统一保留 `手动 / 静音 / 平衡 / 性能` 四种模式
- 在 ViewModel 侧集中做目标转速计算与下发，Helper 专注执行底层 SMC 写入

### 5) 长时间运行下的性能与内存

难点：

- 图表在持续监控时会持续追加点位，容易导致 UI 卡顿和内存抬升

项目做法：

- 温度/风扇趋势图采用时间窗口与降采样策略
- 自动标注采用节流和数量上限
- 高频读取路径加入缓存 TTL 与 in-flight 任务去重

## 目录结构

```text
AuraWind/
├── AuraWind/
│   ├── Assets.xcassets/
│   ├── Models/
│   ├── Services/
│   │   └── HelperTool/
│   ├── Utils/
│   ├── ViewModels/
│   ├── Views/
│   │   ├── Components/
│   │   ├── Main/
│   │   └── Settings/
│   └── AuraWindApp.swift
├── SMCHelper/
├── AuraWind.xcodeproj/
├── docs/
└── 打包并安装.sh
```

## 环境要求

- macOS 15+
- Xcode 16+
- Apple Silicon（已在本机场景优化）

## 启动与开发

### 1) Xcode 启动（开发调试）

```bash
open AuraWind.xcodeproj
```

在 Xcode 中选择 `AuraWind` scheme，直接 Run。

### 2) 命令行构建

```bash
xcodebuild -project AuraWind.xcodeproj \
  -scheme AuraWind \
  -configuration Debug \
  -derivedDataPath /tmp/AuraWindDerivedData \
  build
```

### 3) 本机一键打包与安装（推荐）

```bash
./打包并安装.sh
```

脚本会执行：

1. Release 构建
2. 将 Helper 嵌入 `.app`
3. ad-hoc 签名
4. 复制到桌面 `~/Desktop/AuraWind.app`
5. 安装并启动 `/Library/PrivilegedHelperTools/com.aurawind.AuraWind.SMCHelper`

### 4) 图标更新流程（可复用）

当你替换了 `AuraWind/icon/logo.png`，可按下面流程更新 App 图标：

1. 生成带留白的 AppIcon 源图（避免 Dock 视觉过大）
2. 重新生成 `AppIcon.appiconset` 下全部尺寸
3. 重新构建应用

当前仓库已提供生成后的输入图：`AuraWind/icon/logo_appicon_source.png`

## 打包与发布操作

### 本机使用版（无需对外分发）

直接使用：

```bash
./打包并安装.sh
```

### 手工打包（高级）

```bash
xcodebuild -project AuraWind.xcodeproj \
  -scheme AuraWind \
  -configuration Release \
  -derivedDataPath /tmp/AuraWindDD \
  clean build
```

产物路径：

- `/tmp/AuraWindDD/Build/Products/Release/AuraWind.app`
- `/tmp/AuraWindDD/Build/Products/Release/com.aurawind.AuraWind.SMCHelper`

## 常见排障

### 1) 温度显示为 0

- 检查 Helper 是否运行：

```bash
launchctl print system/com.aurawind.AuraWind.SMCHelper | rg 'state ='
```

- 若不是 `running`，重新执行 `./打包并安装.sh`
- 若 Helper 运行但仍有 0°C：
  - 多半是该机型下对应键无效，属于传感器可用性问题，不是 UI 格式化问题
  - 优先查看可用传感器扫描结果，再决定是否把该键加入黑名单/白名单

### 2) 风扇控制无效

- 确认当前不是冲突模式
- 切到 `性能` 模式验证是否能拉满转速
- 查看 Helper 日志与连接状态

### 3) 构建目录权限异常

若历史构建目录含 root 文件，清理：

```bash
sudo rm -rf Build
```

## 安全说明

- 项目以本机使用为前提设计
- 不上传温度与风扇数据到远端
- Helper 仅用于 SMC 读写能力，不承载业务 UI 逻辑

## License

当前仓库未单独提供开源许可证文件；若需要对外发布，请先补充 `LICENSE` 与分发策略。
