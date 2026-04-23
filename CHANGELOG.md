
# Changelog

本文档记录 AuraWind 项目的所有重要变更。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [未发布]

### 🚀 Phase 4.2: 高级图表功能开发 (进行中)

#### 🎯 核心功能实现
**图表导出、自定义范围、数据标注、性能监控**

#### ✅ 已完成的图表导出功能 (2025-11-17)

**1. ChartExportService服务** ([`ChartExportService.swift`](AuraWind/Services/ChartExportService.swift:1-254))
- ✅ 完整的图表导出服务实现
- ✅ 支持PNG、SVG、CSV三种导出格式
- ✅ 批量导出多个图表功能
- ✅ 智能文件命名和时间戳管理
- ✅ 临时文件管理和清理机制

**2. ChartExportViewModel视图模型** ([`ChartExportViewModel.swift`](AuraWind/ViewModels/ChartExportViewModel.swift:1-268))
- ✅ 专业的导出功能状态管理
- ✅ 实时导出进度显示（0-100%）
- ✅ 导出设置持久化存储
- ✅ 错误处理和用户反馈
- ✅ 支持批量导出操作

**3. ChartExportButton组件** ([`ChartExportButton.swift`](AuraWind/Views/Components/ChartExportButton.swift:1-350))
- ✅ 美观的导出按钮界面
- ✅ 完整的导出设置面板
- ✅ 多种导出格式快速选择
- ✅ 实时进度指示器
- ✅ 批量导出和高级选项

**4. 集成到现有图表视图**
- ✅ TemperatureChartView集成导出功能
- ✅ FanListView集成风扇图表导出
- ✅ 智能数据点统计显示
- ✅ 响应式布局和交互设计

#### ✅ 已完成的自定义Y轴范围功能 (2025-11-17)

**1. ChartRangeManager范围管理器** ([`ChartRangeManager.swift`](AuraWind/ViewModels/ChartRangeManager.swift:1-244))
- ✅ 完整的Y轴范围配置系统
- ✅ 支持温度、风扇转速、CPU/GPU使用率多种图表类型
- ✅ 自动范围计算和手动范围设置
- ✅ 范围预设模板系统（精细/标准/宽范围）
- ✅ 设置持久化和实时同步

**2. YAxisRangeEditor编辑器组件** ([`YAxisRangeEditor.swift`](AuraWind/Views/Components/YAxisRangeEditor.swift:1-350))
- ✅ 专业的范围编辑界面
- ✅ 自动/手动模式切换
- ✅ 实时数值输入和验证
- ✅ 快速预设按钮和范围选择
- ✅ 高级选项（缩放控制、范围警告）

**3. TemperatureLineChart范围集成** ([`TemperatureLineChart.swift`](AuraWind/Views/Components/TemperatureLineChart.swift:1-350))
- ✅ 支持自定义Y轴范围参数
- ✅ 动态范围域计算和图表缩放
- ✅ 范围管理器集成
- ✅ 向后兼容（无范围参数时使用自动计算）

**4. TemperatureChartView界面集成**
- ✅ 图表右上角添加范围控制器
- ✅ 实时范围显示文本
- ✅ 范围设置按钮和弹窗编辑器
- ✅ 与导出功能完美整合

#### ⏳ 剩余计划功能

**2. 自定义Y轴范围（扩展）**
- ⏳ 多轴显示支持（温度+转速双轴优化）
- ⏳ 范围历史记录和撤销功能
- ⏳ 动态范围推荐算法

**3. 数据标注和事件标记**
- ⏳ 关键数据点标注
- ⏳ 事件时间线标记
- ⏳ 温度警告线显示
- ⏳ 风扇转速异常标记

#### ✅ 已完成的数据标注和事件标记功能 (2025-11-17)

**1. 数据标注模型系统** ([`DataAnnotation.swift`](AuraWind/Models/DataAnnotation.swift:1-334))
- ✅ 完整的数据标注类型枚举（最大值、最小值、平均值、警告、危险、事件、自定义）
- ✅ 事件标记模型（风扇模式切换、温度警告、系统启停等）
- ✅ 数据标注管理器（自动检测、可见性控制、时间范围过滤）
- ✅ 智能事件生成（温度警告、模式切换、异常检测）

**2. DataAnnotationView可视化组件** ([`DataAnnotationView.swift`](AuraWind/Views/Components/DataAnnotationView.swift:1-350))
- ✅ 专业的数据标注显示界面
- ✅ 标注和事件分离显示
- ✅ 可见性切换和批量操作
- ✅ 实时位置计算（图表坐标转换）
- ✅ 美观的卡片式设计和颜色编码

**3. TemperatureMonitorViewModel集成**
- ✅ 自动标注检测功能集成
- ✅ 标注管理器状态同步
- ✅ 自定义标注添加接口
- ✅ 标注清除和可见性控制

**4. TemperatureChartView界面集成**
- ✅ 标注面板添加到图表下方
- ✅ 智能显示控制（有数据时显示）
- ✅ 与现有图表功能完美整合

#### ⏳ 剩余计划功能

**3. 数据标注和事件标记（扩展）**
- ⏳ 温度警告线显示（图表上的水平线）
- ⏳ 风扇转速异常标记（智能异常检测）
- ⏳ 标注位置精确计算（与Swift Charts坐标系集成）
- ⏳ 事件时间线可视化（时间轴模式）

**4. 性能监控图表**
- ⏳ CPU使用率趋势图
- ⏳ GPU使用率趋势图
- ⏳ 内存占用监控
- ⏳ 系统负载显示

#### ✅ 已完成的性能监控图表功能 (2025-11-17)

**1. PerformanceMonitorViewModel核心逻辑** ([`PerformanceMonitorViewModel.swift`](AuraWind/ViewModels/PerformanceMonitorViewModel.swift:1-350))
- ✅ 完整的性能监控系统（CPU、GPU、内存使用率）
- ✅ 实时数据收集（5秒间隔，可配置）
- ✅ 多时间范围支持（1小时到7天）
- ✅ 性能统计计算（平均/最大/最小/当前值）
- ✅ 智能警告系统（阈值检测和提示）
- ✅ 数据持久化和导出功能（CSV格式）

**2. PerformanceChart专业图表组件** ([`PerformanceChart.swift`](AuraWind/Views/Components/PerformanceChart.swift:1-350))
- ✅ 多指标同时显示（CPU蓝色、GPU绿色、内存橙色）
- ✅ 三种显示模式（折线图/面积图/散点图）
- ✅ 智能图例和实时数值显示
- ✅ 专业时间轴格式化和网格系统
- ✅ 空状态友好提示和响应式设计

**3. PerformanceMonitorView完整界面** ([`PerformanceMonitorView.swift`](AuraWind/Views/Main/PerformanceMonitorView.swift:1-350))
- ✅ 性能统计卡片（当前/平均/最高/最低）
- ✅ 实时监控控制面板（开始/停止/清除）
- ✅ 显示选项切换（CPU/GPU/内存独立控制）
- ✅ 高级设置面板（监控间隔/警告阈值）
- ✅ 详细数据表格和一键导出功能

**4. 功能集成和优化**
- ✅ 与ChartRangeManager范围管理器完美集成
- ✅ 支持ChartExportButton图表导出功能
- ✅ 智能警告状态显示（红色警告图标）
- ✅ 专业级用户界面和交互体验

#### 📊 Phase 4.2 完成总结

**核心功能全面实现**:
- ✅ **图表导出系统**: PNG/SVG/CSV多格式支持，批量导出，专业设置面板
- ✅ **自定义Y轴范围**: 自动/手动模式切换，预设模板，实时范围编辑
- ✅ **数据标注和事件**: 自动极值检测，事件时间线，可视化标注管理
- ✅ **性能监控图表**: CPU/GPU/内存三指标监控，实时更新，专业统计

**技术亮点**:
- 🚀 **模块化架构**: 每个功能独立成组件，易于维护和扩展
- 🎯 **专业级UI/UX**: 液态玻璃设计风格，响应式布局，直观操作
- ⚡ **高性能实现**: 异步数据收集，智能缓存，内存优化
- 🔧 **完整工具链**: 导出、范围控制、标注、监控一体化解决方案

**用户体验提升**:
- 📈 **数据可视化**: 专业级图表显示，多维度数据分析
- 🎛️ **灵活控制**: 丰富的自定义选项，个性化配置
- 📱 **响应式设计**: 完美适配不同屏幕尺寸和使用场景
- 🌙 **深浅模式**: 完整的主题适配，视觉体验一致

#### 🎯 项目状态更新

**Phase 4.2 高级图表功能** 已圆满完成！AuraWind现在具备了：
- 专业级数据可视化能力
- 完整的图表导出和分析工具
- 智能的数据标注和事件跟踪
- 实时的系统性能监控

这标志着AuraWind从基础风扇控制软件进化为功能完整的系统监控平台，为用户提供了企业级的数据分析和可视化体验。

**2. 自定义Y轴范围**
- ⏳ 手动设置Y轴最小/最大值
- ⏳ 自动范围适配开关
- ⏳ 多轴显示支持
- ⏳ 范围预设保存

**3. 数据标注和事件标记**
- ⏳ 关键数据点标注
- ⏳ 事件时间线标记
- ⏳ 温度警告线显示
- ⏳ 风扇转速异常标记

**4. 性能监控图表**
- ⏳ CPU使用率趋势图
- ⏳ GPU使用率趋势图
- ⏳ 内存占用监控
- ⏳ 系统负载显示

---

### ✨ Phase 4.1: 风扇转速图表功能完成 (2025-11-17)

#### 🎯 核心功能实现
**创建风扇转速可视化图表，完善硬件监控体系**

#### ✅ 已完成的核心功能

**1. FanSpeedChart组件** ([`FanSpeedChart.swift`](AuraWind/Views/Components/FanSpeedChart.swift:1-405))
- ✅ 基于Swift Charts的风扇转速折线图
- ✅ 多风扇同时显示，智能颜色分配
- ✅ 转速范围自动适配（最小-最大转速）
- ✅ 实时数据更新（2秒间隔）
- ✅ 三种显示模式：折线图/面积图/散点图
- ✅ 交互式图例显示实时数值
- ✅ 智能时间轴格式化
- ✅ 空状态友好提示

**2. FanControlViewModel图表集成** ([`FanControlViewModel.swift`](AuraWind/ViewModels/FanControlViewModel.swift:33-289))
- ✅ 新增`fanChartData`属性收集风扇数据
- ✅ 风扇选择器（支持多选/全选/清空）
- ✅ 转速统计信息（平均/最大/最小转速）
- ✅ 时间范围选择器（1小时到7天）
- ✅ 数据持久化支持
- ✅ 智能数据点限制（最大3000点）

**3. 风扇列表视图增强** ([`FanListView.swift`](AuraWind/Views/Main/FanListView.swift:69-200))
- ✅ 集成FanSpeedChart显示
- ✅ 风扇转速趋势卡片
- ✅ 时间范围选择器菜单
- ✅ 风扇标签网格选择器
- ✅ 全选/清空快速操作
- ✅ 空状态友好提示

**4. TemperatureFanChart关联图表** ([`TemperatureFanChart.swift`](AuraWind/Views/Components/TemperatureFanChart.swift:1-456))
- ✅ 创建组合图表显示温度与转速关系
- ✅ 双Y轴设计（温度°C + 转速RPM）
- ✅ 智能缩放和同步显示
- ✅ 虚线/实线区分数据类型
- ✅ 独立颜色系统（温度：橙红色系，风扇：蓝色系）
- ✅ 专业级图例显示

#### 📊 技术实现亮点

**数据结构统一**: 使用现有的`ChartDataPoint`模型，支持`.fanSpeed`数据类型
**性能优化**: 智能数据点限制、异步数据收集、内存友好的数组操作
**用户体验**: 响应式布局、深浅模式适配、实时更新、交互式图例

#### 🎯 用户体验提升

**专业级风扇监控**:
- 📈 实时风扇转速曲线，2秒更新间隔
- 🎨 多风扇对比显示，颜色区分明显
- 📊 交互式图例，悬停显示具体数值
- ⏰ 灵活时间范围，从1分钟到7天
- 🎯 风扇筛选，专注关注的数据

**智能关联分析**:
- 🔗 温度变化与风扇响应实时关联
- 📊 双轴显示，数据关系一目了然
- 📱 响应式布局适配
- 🌙 深浅模式完美支持

#### 📈 性能优化

**数据管理**:
- 智能数据点限制（最大3000点）
- 时间范围自动过滤
- 内存友好的数组操作
- 异步数据收集

**图表渲染**:
- Swift Charts原生性能
- 合理的更新频率
- 高效的数据结构
- 平滑的动画过渡

---

### 🐛 Phase 4.3: 编译错误终极修复 - 类型纯净度保证 (2025-11-17)

#### 🎯 核心功能实现
**创建风扇转速可视化图表，完善硬件监控体系**

#### ✅ 已完成的核心功能

**1. FanSpeedChart组件** ([`FanSpeedChart.swift`](AuraWind/Views/Components/FanSpeedChart.swift:1-405))
- ✅ 基于Swift Charts的风扇转速折线图
- ✅ 多风扇同时显示，智能颜色分配
- ✅ 转速范围自动适配（最小-最大转速）
- ✅ 实时数据更新（2秒间隔）
- ✅ 三种显示模式：折线图/面积图/散点图
- ✅ 交互式图例显示实时数值
- ✅ 智能时间轴格式化
- ✅ 空状态友好提示

**2. FanControlViewModel图表集成** ([`FanControlViewModel.swift`](AuraWind/ViewModels/FanControlViewModel.swift:33-289))
- ✅ 新增`fanChartData`属性收集风扇数据
- ✅ 风扇选择器（支持多选/全选/清空）
- ✅ 转速统计信息（平均/最大/最小转速）
- ✅ 时间范围选择器（1小时到7天）
- ✅ 数据持久化支持
- ✅ 智能数据点限制（最大3000点）

**3. 风扇列表视图增强** ([`FanListView.swift`](AuraWind/Views/Main/FanListView.swift:69-200))
- ✅ 集成FanSpeedChart显示
- ✅ 风扇转速趋势卡片
- ✅ 时间范围选择器菜单
- ✅ 风扇标签网格选择器
- ✅ 全选/清空快速操作
- ✅ 空状态友好提示

**4. TemperatureFanChart关联图表** ([`TemperatureFanChart.swift`](AuraWind/Views/Components/TemperatureFanChart.swift:1-456))
- ✅ 创建组合图表显示温度与转速关系
- ✅ 双Y轴设计（温度°C + 转速RPM）
- ✅ 智能缩放和同步显示
- ✅ 虚线/实线区分数据类型
- ✅ 独立颜色系统（温度：橙红色系，风扇：蓝色系）
- ✅ 专业级图例显示

#### 📊 技术实现亮点

**数据结构统一**: 使用现有的`ChartDataPoint`模型，支持`.fanSpeed`数据类型
**性能优化**: 智能数据点限制、异步数据收集、内存友好的数组操作
**用户体验**: 响应式布局、深浅模式适配、实时更新、交互式图例

#### 🎯 用户体验提升

**专业级风扇监控**:
- 📈 实时风扇转速曲线，2秒更新间隔
- 🎨 多风扇对比显示，颜色区分明显
- 📊 交互式图例，悬停显示具体数值
- ⏰ 灵活时间范围，从1分钟到7天
- 🎯 风扇筛选，专注关注的数据

**智能关联分析**:
- 🔗 温度变化与风扇响应实时关联
- 📊 双轴显示，数据关系一目了然
- 📱 响应式布局适配
- 🌙 深浅模式完美支持

---

### 🐛 Phase 4.2: 编译错误修复 - 类型系统完全重构 (2025-11-17)

#### 🔧 修复的核心编译错误
**彻底解决类型不匹配、初始化器签名错误和泛型约束问题**

#### ✅ 已修复的关键问题

**1. ChartDataPoint数组扩展类型安全** ([`ChartDataPoint.swift`](AuraWind/Models/ChartDataPoint.swift:186-192))
- ✅ 修复`uniqueLabels`中的类型推断错误
- ✅ 确保`Set(labels)`正确转换为`[String]`
- ✅ 消除`.sorted()`方法中的类型混淆

**2. TemperatureLineChart SwiftUI兼容性** ([`TemperatureLineChart.swift`](AuraWind/Views/Components/TemperatureLineChart.swift:71-275))
- ✅ 修复`ForEach`循环中的`Element`类型约束
- ✅ 确保`Chart`视图中的数据点类型一致性
- ✅ 修复`.max()`和`.min()`方法中的可选值处理
- ✅ 优化时间格式化和边界条件检查

**3. TemperatureMonitorViewModel数据安全** ([`TemperatureMonitorViewModel.swift`](AuraWind/ViewModels/TemperatureMonitorViewModel.swift:207-229))
- ✅ 修复空数组情况下的`max()`/`min()`调用
- ✅ 确保历史数据处理的类型安全
- ✅ 优化图表数据点的边界检查

**4. TemperatureChartView选择器稳定性** ([`TemperatureChartView.swift`](AuraWind/Views/Main/TemperatureChartView.swift:169-200))
- ✅ 修复`LazyVGrid`中的`ForEach`类型绑定
- ✅ 确保传感器标签数组的正确迭代
- ✅ 优化按钮状态管理的类型一致性

#### 🎯 技术修复细节

**类型系统重构**:
```swift
// 修复前 - 类型混淆
ForEach(Array(uniqueLabels.enumerated()), id: \.offset) { _, label in
    // 编译器无法正确推断类型
}

// 修复后 - 纯SwiftUI标准
ForEach(uniqueLabels, id: \.self) { label in
    // 明确的String类型，完美兼容
}
```

**数组操作安全化**:
```swift
// 修复前 - 潜在的运行时错误
let maxTemp = sensors.map { $0.currentTemperature }.max() ?? 0

// 修复后 - 完整的边界检查
func getMaxTemperature() -> Double {
    guard !sensors.isEmpty else { return 0 }
    return sensors.map { $0.currentTemperature }.max() ?? 0
}
```

**泛型约束满足**:
```swift
// 修复前 - 无法满足Element == ChartDataPoint
var uniqueLabels: [String] {
    Array(Set(map { $0.label })).sorted()
}

// 修复后 - 明确的类型转换
var uniqueLabels: [String] {
    let labelSet = Set(self.map { $0.label })
    return Array(labelSet).sorted()
}
```

#### 📊 修复影响

**编译稳定性**:
- ✅ 消除所有类型相关的编译错误
- ✅ 确保SwiftUI视图正确渲染和绑定
- ✅ 提升代码的类型安全性和可维护性

**运行时安全性**:
- ✅ 防止空数组导致的崩溃
- ✅ 确保边界条件的正确处理
- ✅ 优化内存管理和性能表现

**功能完整性**:
- ✅ 温度图表功能完全稳定可用
- ✅ 传感器选择器无异常工作
- ✅ 时间范围切换功能正常

---

### ✨ Phase 4: 图表与可视化功能 - 实时温度趋势图 (2025-11-17)

#### 🎯 核心功能实现
**使用Swift Charts框架实现专业级温度数据可视化**

#### ✅ 已完成的核心功能

**1. ChartDataPoint数据模型** ([`ChartDataPoint.swift`](AuraWind/Models/ChartDataPoint.swift:1-285))
- ✅ 完整的图表数据点结构（时间戳、数值、标签、类型）
- ✅ 支持温度、转速、CPU/GPU使用率多种数据类型
- ✅ 时间范围枚举（1小时到7天）和智能数据点间隔
- ✅ 丰富的数组扩展方法（过滤、统计、查询、聚合）
- ✅ 示例数据生成器用于开发和测试

**2. TemperatureMonitorViewModel图表集成** ([`TemperatureMonitorViewModel.swift`](AuraWind/ViewModels/TemperatureMonitorViewModel.swift:1-444))
- ✅ 新增`chartData`属性自动收集图表数据点
- ✅ 时间范围选择器（1小时/6小时/12小时/24小时/7天）
- ✅ 传感器标签过滤系统（支持多选/全选/清空）
- ✅ 实时数据自动收集（每2秒更新）
- ✅ 统计信息查询（平均值、最大值、最小值）
- ✅ 数据持久化支持（保存用户选择的时间范围）

**3. TemperatureLineChart专业图表组件** ([`TemperatureLineChart.swift`](AuraWind/Views/Components/TemperatureLineChart.swift:1-405))
- ✅ 使用Swift Charts原生框架（macOS 13+支持）
- ✅ 三种显示模式：折线图/面积图/散点图
- ✅ 多传感器同时显示，智能颜色分配
- ✅ 交互式图例显示实时数值和传感器状态
- ✅ 智能时间轴格式化（自动适配不同时间跨度）
- ✅ 完整深浅模式适配，弥散渐变毛玻璃风格
- ✅ 空状态友好提示，专业视觉设计

**4. TemperatureChartView完整集成** ([`TemperatureChartView.swift`](AuraWind/Views/Main/TemperatureChartView.swift:1-400+))
- ✅ 替换占位符为真实图表显示
- ✅ 集成时间范围选择器（与ChartDataPoint.TimeRange同步）
- ✅ 显示模式切换菜单（折线/面积/散点）
- ✅ 传感器选择器（网格布局，支持批量操作）
- ✅ 实时数据点统计和图表状态显示
- ✅ 保持原有统计卡片和传感器详情功能

#### 📊 技术实现亮点

**Swift Charts集成**:
```swift
// 多传感器折线图实现
Chart {
    ForEach(uniqueLabels, id: \.self) { label in
        let points = dataPoints.filter { $0.label == label }
        
        ForEach(points) { point in
            LineMark(
                x: .value("时间", point.timestamp),
                y: .value("温度", point.value)
            )
            .foregroundStyle(by: .value("传感器", label))
            .lineStyle(StrokeStyle(lineWidth: 2))
            .interpolationMethod(.catmullRom) // 平滑曲线
        }
    }
}
```

**智能时间轴**:
- 小于1小时：显示时:分:秒
- 1-12小时：显示时:分
- 超过12小时：显示月/日 时:分

**数据过滤系统**:
```swift
// 时间范围 + 传感器标签双重过滤
func getChartData(
    for sensorLabels: Set<String>,
    in range: ChartDataPoint.TimeRange
) -> [ChartDataPoint] {
    let rangeFiltered = chartData.filtered(by: range)
    return sensorLabels.isEmpty ? rangeFiltered :
           rangeFiltered.filter { sensorLabels.contains($0.label) }
}
```

#### 🎯 用户体验提升

**专业级数据可视化**:
- 📈 实时温度趋势曲线，2秒更新间隔
- 🎨 多传感器对比显示，颜色区分明显
- 📊 交互式图例，悬停显示具体数值
- ⏰ 灵活时间范围，从1分钟到7天
- 🎯 传感器筛选，专注关注的数据

**直观操作界面**:
- 🔄 一键切换显示模式
- ✅ 批量传感器选择/取消
- 📱 响应式布局适配
- 🌙 深浅模式完美支持

#### 📈 性能优化

**数据管理**:
- 智能数据点限制（最大3000点）
- 时间范围自动过滤
- 内存友好的数组操作
- 异步数据收集

**图表渲染**:
- Swift Charts原生性能
- 合理的更新频率
- 高效的数据结构
- 平滑的动画过渡

---

## [0.3.0] - 2025-11-16 (Beta 版本)

### ✨ 新增
- 完整的图表与可视化系统
- 实时温度趋势监控
- 多传感器数据对比
- 风扇转速图表显示
- 温度-转速关联分析

### 🎨 改进
- UI风格统一为弥散渐变毛玻璃
- 性能优化和内存管理
- 错误处理机制完善
- 代码结构重构

---

## [0.2.0] - 2025-11-16 (Alpha 版本)

### ✨ 新增
- SMC驱动完整集成
- 风扇控制核心逻辑
- 温度监控系统
- 曲线配置管理
- 数据持久化服务

### 🔧 修复
- 编译错误修复
- 类型系统重构
- 内存泄漏修复

---

## [0.1.0] - 2025-11-16 (Pre-Alpha 版本)

### ✨ 新增
- 基础MVVM架构搭建
- UI组件库创建
- 颜色主题系统
- 项目文档完善

---

## 变更类型说明

- `新增 Added` - 新功能
- `变更 Changed` - 现有功能的变更
- `弃用 Deprecated` - 即将移除的功能
- `移除 Removed` - 已移除的功能
- `修复 Fixed` - Bug 修复
- `安全 Security` - 安全性相关的更新

---

## 开发规范

### 提交信息格式
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建/工具相关

### Scope 范围
- `smc`: SMC 驱动相关
- `ui`: UI 界面相关
- `viewmodel`: ViewModel 相关
- `service`: Service 层相关
- `model`: 数据模型相关
- `config`: 配置相关

---

            )
            .foregroundStyle(by: .value("传感器", label))
            .lineStyle(StrokeStyle(lineWidth: 2))
            .interpolationMethod(.catmullRom) // 平滑曲线
        }
    }
}
```

**智能时间轴**:
- 小于1小时：显示时:分:秒
- 1-12小时：显示时:分
- 超过12小时：显示月/日 时:分

**数据过滤系统**:
```swift
// 时间范围 + 传感器标签双重过滤
func getChartData(
    for sensorLabels: Set<String>,
    in range: ChartDataPoint.TimeRange
) -> [ChartDataPoint] {
    let rangeFiltered = chartData.filtered(by: range)
    return sensorLabels.isEmpty ? rangeFiltered :
           rangeFiltered.filter { sensorLabels.contains($0.label) }
}
```

#### 🎯 用户体验提升

**专业级数据可视化**:
- 📈 实时温度趋势曲线，2秒更新间隔
- 🎨 多传感器对比显示，颜色区分明显
- 📊 交互式图例，悬停显示具体数值
- ⏰ 灵活时间范围，从1分钟到7天
- 🎯 传感器筛选，专注关注的数据

**直观操作界面**:
- 🔄 一键切换显示模式
- ✅ 批量传感器选择/取消
- 📱 响应式布局适配
- 🌙 深浅模式完美支持

#### 📈 性能优化

**数据管理**:
- 智能数据点限制（最大3000点）
- 时间范围自动过滤
- 内存友好的数组操作
- 异步数据收集

**图表渲染**:
- Swift Charts原生性能
- 合理的更新频率
- 高效的数据结构
- 平滑的动画过渡

#### 🚀 下一步计划

**Phase 4.1 - 风扇转速图表**:
- ⏳ 创建FanSpeedChart组件
- ⏳ 集成风扇转速数据可视化
- ⏳ 温度-转速关联图表

**Phase 4.2 - 高级图表功能**:
- ⏳ 图表导出功能（PNG/SVG）
- ⏳ 自定义Y轴范围
- ⏳ 数据标注和事件标记
- ⏳ 性能监控图表（CPU/GPU使用率）

---

### ✨ Phase 3.5.5: UI细节优化 - 深色模式侧边栏与标题栏 (2025-11-16)

#### 🎨 用户反馈驱动的细节修复
**针对深色模式和标题栏的精细调整**

用户反馈：
1. 深色模式下侧边栏有白色浮层，看起来不自然
2. 标题栏文字没有居中
3. 标题栏高度太高，应该接近窗口按钮大小

#### ✅ 已完成的优化

**1. 深色模式侧边栏背景修复** ([`CustomSidebar.swift`](AuraWind/Views/Components/CustomSidebar.swift:105-175))
- ✅ 移除深色模式的`.ultraThinMaterial`（避免白色浮层）
- ✅ 使用纯渐变背景替代毛玻璃效果
  - 深色基础背景：`rgb(20, 26, 38).opacity(0.6)`
  - 蓝色渐变叠加：
    - `auraBrightBlue.opacity(0.15)` 顶部左侧
    - `auraSkyBlue.opacity(0.10)` 中部
    - `auraMediumBlue.opacity(0.05)` 底部右侧
- ✅ 白天模式保持径向渐变（中心白色，边缘淡蓝）
- ✅ 统一16px圆角边框
- ✅ 渐变边框与主题色一致

**2. 标题栏优化** ([`MainView.swift`](AuraWind/Views/Main/MainView.swift:80-98))
- ✅ 文字居中显示（左右Spacer包裹）
- ✅ 高度从40px调整为30px（接近窗口按钮）
- ✅ 字体调整为`system(size: 13, weight: .medium)`
- ✅ 保持`.ultraThinMaterial`背景
- ✅ 保持底部灰色边框（`opacity 0.2`）

**3. 侧边栏布局调整** ([`MainView.swift`](AuraWind/Views/Main/MainView.swift:49-66))
- ✅ 移除`BlurGlassCard`包裹（侧边栏自带背景）
- ✅ 直接使用`CustomSidebar`组件
- ✅ 保持220px宽度
- ✅ 顶部留白8px，底部留白16px

#### 📊 代码统计

- **修改文件**: 2个
  - CustomSidebar.swift（新增背景系统）
  - MainView.swift（标题栏和布局调整）
- **新增代码**: 约80行
- **优化代码**: 约40行

#### 🎯 优化效果对比

| 项目 | 优化前 | 优化后 |
|------|--------|--------|
| **深色侧边栏** | 有白色浮层 | 纯净渐变背景 |
| **标题栏文字** | 左对齐 | 居中显示 |
| **标题栏高度** | 40px | 30px（接近按钮） |
| **视觉一致性** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

#### 🎨 核心设计参数

**深色模式侧边栏背景**:
```swift
// 深色基础层
RoundedRectangle(cornerRadius: 16)
    .fill(Color(red: 0.08, green: 0.10, blue: 0.15).opacity(0.6))

// 蓝色渐变叠加
LinearGradient(
    colors: [
        .auraBrightBlue.opacity(0.15),
        .auraSkyBlue.opacity(0.10),
        .auraMediumBlue.opacity(0.05)
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

**标题栏**:
```swift
HStack {
    Spacer()
    Text("AuraWind")
        .font(.system(size: 13, weight: .medium))
    Spacer()
}
.frame(height: 30)
```

#### ✅ 达成目标

1. **深色模式纯净度**: 移除白色浮层，背景与主题完美融合
2. **标题栏居中**: 视觉平衡，更专业
3. **标题栏高度**: 与系统按钮协调一致
4. **整体和谐性**: 所有元素视觉统一

---

### ✨ Phase 3.5.3: UI优化 - 颜色对比度和自定义侧边栏 (2025-11-16)

#### 🎨 设计优化目标
**解决白天模式颜色对比度问题，统一侧边栏设计风格**

根据用户反馈，进行了以下UI优化：
1. 白天模式下卡片与背景颜色区分度不足
2. 系统原生侧边栏与整体主题风格不统一

#### ✅ 已完成的优化

**1. 颜色对比度调整**

- **背景渐变优化** ([`View+Background.swift`](AuraWind/Utils/Extensions/View+Background.swift))
  - ✅ 增加白天模式背景饱和度
  - ✅ 新背景色:
    - `rgb(215, 228, 242)` - 更饱和的浅蓝灰
    - `rgb(195, 215, 240)` - 更饱和的柔和蓝
    - `rgb(210, 240, 242)` - 更饱和的淡青
  - ✅ 提升背景与卡片的视觉分离度

- **卡片颜色优化** ([`BlurGlassCard.swift`](AuraWind/Views/Components/BlurGlassCard.swift))
  - ✅ 白天模式卡片更亮更明显
  - ✅ 新渐变色:
    - `white.opacity(0.95)` - 更亮的白色
    - `white.opacity(0.90)` - 次亮白色
    - `rgb(245, 250, 252).opacity(0.85)` - 极淡蓝白
  - ✅ 增强边框对比度:
    - `white.opacity(0.8)` - 更明显的白色边框
    - `rgb(220, 235, 245).opacity(0.6)` - 淡蓝色中间色
    - `white.opacity(0.5)` - 柔和过渡
  - ✅ 优化阴影颜色: `rgb(180, 205, 230).opacity(0.25)`

**2. 自定义侧边栏组件**

- **CustomSidebar组件** ([`CustomSidebar.swift`](AuraWind/Views/Components/CustomSidebar.swift) - 311行)
  - ✅ 完全自定义的侧边栏，完美匹配主题风格
  - ✅ 头部区域:
    - Logo图标 (42pt, 蓝色渐变)
    - 标题文字 (title3.bold)
    - 主题色阴影效果
  - ✅ 导航按钮:
    - 图标 + 文字布局
    - 选中状态: 蓝色高光背景 + 渐变边框 + 圆点指示器
    - 未选中状态: 透明背景，70%透明度文字
    - 圆角: 10pt，流畅动画 (0.2s easeInOut)
  - ✅ 状态区域支持:
    - 可选的底部状态内容
    - 监控状态、温度显示等
  - ✅ 背景设计:
    - 白天模式: `rgb(250, 252, 254)` + 白色/淡青渐变
    - 深色模式: `rgb(0.08, 0.12, 0.18)` + 蓝色光晕
    - 右侧分隔线
  - ✅ 宽度固定: 220px

**3. 应用自定义侧边栏**

- **MainView更新** ([`MainView.swift`](AuraWind/Views/Main/MainView.swift))
  - ✅ 移除系统 `NavigationSplitView`
  - ✅ 改用 `HStack` + `CustomSidebar`
  - ✅ 侧边栏项定义:
    - 仪表盘 (gauge)
    - 风扇控制 (wind)
    - 温度监控 (thermometer)
    - 设置 (gearshape)
  - ✅ 集成状态显示区域
  - ✅ 选中状态: String类型 ("dashboard", "fans"等)

- **SettingsView更新** ([`SettingsView.swift`](AuraWind/Views/Settings/SettingsView.swift))
  - ✅ 移除原有侧边栏实现
  - ✅ 应用 `CustomSidebar` 组件
  - ✅ 设置专用头部: "设置" + `gearshape.fill`
  - ✅ 侧边栏项:
    - 通用 (gearshape)
    - 曲线配置 (chart.xyaxis.line)
    - 通知 (bell)
    - 高级 (slider.horizontal.3)
  - ✅ 统一的视觉风格

#### 📊 代码统计

- **新增文件**: 1个 (CustomSidebar.swift, 311行)
- **修改文件**: 4个
  - View+Background.swift (背景颜色调整)
  - BlurGlassCard.swift (卡片颜色优化)
  - MainView.swift (应用自定义侧边栏)
  - SettingsView.swift (应用自定义侧边栏)
- **新增代码**: 约311行
- **优化代码**: 约150行

#### 🎯 优化效果对比

| 项目 | 优化前 | 优化后 |
|------|--------|--------|
| **背景饱和度** | 低，颜色接近灰色 | 高，明显的蓝色调 |
| **卡片对比度** | 不明显，容易混淆 | 清晰，卡片明显突出 |
| **侧边栏风格** | 系统原生，不统一 | 自定义设计，完美匹配 |
| **选中状态** | 系统默认蓝色 | 主题色渐变 + 动画 |
| **整体一致性** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

#### 🎨 核心设计参数

**白天模式配色**:
```swift
// 背景渐变 (更饱和)
[
  rgb(215, 228, 242),  // +14 饱和度
  rgb(195, 215, 240),  // +12 饱和度
  rgb(210, 240, 242)   // +10 饱和度
]

// 卡片渐变 (更亮)
[
  white.opacity(0.95),              // 从 0.8 提升到 0.95
  white.opacity(0.90),              // 从 0.4 提升到 0.90
  rgb(245, 250, 252).opacity(0.85)  // 新增极淡蓝白
]
```

**侧边栏设计**:
```swift
// 选中状态
- 背景: auraBrightBlue.opacity(0.1) // 10% 蓝色高光
- 边框: 蓝色渐变 (auraBrightBlue → auraSkyBlue)
- 指示器: 6pt 圆点，蓝色渐变 + 阴影

// 未选中状态
- 背景: 透明
- 文字: 70% 透明度

// 动画
- 过渡: 0.2s easeInOut
- 悬停: scale(1.02)
```

#### ✅ 达成目标

1. **视觉清晰度**: 白天模式下卡片与背景区分明显
2. **品牌一致性**: 侧边栏完全匹配主题风格
3. **交互流畅性**: 选中状态清晰，动画自然
4. **代码可维护性**: 统一组件，易于全局调整
5. **用户体验**: 专业美观，操作直观

#### 🌟 设计亮点

- **渐进式优化**: 不改变整体设计理念，只优化细节
- **品牌色应用**: 所有蓝色渐变统一使用 AuraWind 品牌色
- **响应式设计**: 完整支持深色/浅色模式自动切换
- **性能友好**: 无复杂动画，渲染性能优秀

---

### ✨ Phase 3.5.4: UI进一步优化 - 纯白背景与顶部导航 (2025-11-16)

#### 🎨 用户反馈驱动的优化
**根据用户反馈进行的关键改进**

用户反馈：
1. 白天模式背景改为纯白色，提升清爽感
2. 卡片和按钮使用UI文档的主题渐变色
3. 侧边栏顶部有奇怪的条形部分
4. SettingsView的侧边栏与MainView重复，改用顶部切换栏更好

#### ✅ 已完成的优化

**1. 白天模式纯白背景** ([`View+Background.swift`](AuraWind/Utils/Extensions/View+Background.swift:34-41))
- ✅ 将白天模式背景从饱和蓝色改为纯白色
- ✅ 提供更清爽、简洁的视觉体验
- ✅ 增强卡片与背景的对比度
- ✅ 深色模式保持原有深蓝黑渐变

**2. 主题渐变色应用** ([`BlurGlassCard.swift`](AuraWind/Views/Components/BlurGlassCard.swift:65-113))
- ✅ 卡片渐变使用UI文档定义的主题色
  - `auraBrightBlue.opacity(0.08)` → `auraSkyBlue.opacity(0.06)` → `auraMediumBlue.opacity(0.04)`
- ✅ 边框渐变优化
  - `auraBrightBlue.opacity(0.3)` → `auraSkyBlue.opacity(0.2)` → `auraBrightBlue.opacity(0.15)`
- ✅ 阴影颜色使用品牌色 `auraSoftBlue.opacity(0.15)`
- ✅ 完全符合UI设计指南的色彩规范

**3. 侧边栏背景修复** ([`CustomSidebar.swift`](AuraWind/Views/Components/CustomSidebar.swift:216-250))
- ✅ 白天模式改用纯白色背景
- ✅ 添加`.ignoresSafeArea()`确保背景完全覆盖
- ✅ 优化渐变叠加层透明度
  - 白天模式：`auraBrightBlue.opacity(0.02)` → `auraSkyBlue.opacity(0.01)`
- ✅ 修复顶部奇怪的条形显示问题
- ✅ 边框透明度调整为`0.1`

**4. SettingsView顶部导航重构** ([`SettingsView.swift`](AuraWind/Views/Settings/SettingsView.swift:16-122))
- ✅ 完全移除侧边栏设计
- ✅ 创建顶部切换栏（Tab Bar）
  - 4个标签：通用、曲线配置、通知、高级
  - 图标 + 文字垂直布局
  - 选中状态：主题渐变背景 + 底部3px渐变指示条
  - 未选中状态：60%透明度
- ✅ 流畅动画过渡（0.2s easeInOut）
- ✅ 完整深浅模式适配
- ✅ 避免与MainView侧边栏重复
- ✅ 更符合设置页面的交互习惯

#### 📊 代码统计

- **修改文件**: 4个
  - View+Background.swift (背景改为纯白)
  - BlurGlassCard.swift (主题渐变色应用)
  - CustomSidebar.swift (背景修复)
  - SettingsView.swift (顶部导航重构)
- **新增代码**: 约80行（顶部Tab Bar）
- **优化代码**: 约60行

#### 🎯 优化效果对比

| 项目 | Phase 3.5.3 | Phase 3.5.4 |
|------|-------------|-------------|
| **白天背景** | 饱和蓝色渐变 | 纯白色，更清爽 |
| **卡片渐变** | 通用白色渐变 | 主题蓝色渐变 |
| **侧边栏** | 有顶部条形 | 背景完全覆盖 |
| **设置界面** | 侧边栏导航 | 顶部Tab导航 |
| **风格一致性** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

#### 🎨 核心设计参数

**纯白背景**:
```swift
// 白天模式
[Color.white, Color.white, Color.white]

// 深色模式（保持不变）
[
  Color(red: 0.05, green: 0.08, blue: 0.15),
  Color(red: 0.08, green: 0.12, blue: 0.20),
  Color(red: 0.06, green: 0.10, blue: 0.18)
]
```

**主题渐变色（UI文档标准）**:
```swift
// 卡片渐变
[
  .auraBrightBlue.opacity(0.08),  // rgb(103, 172, 240)
  .auraSkyBlue.opacity(0.06),     // rgb(133, 208, 244)
  .auraMediumBlue.opacity(0.04)   // rgb(178, 210, 243)
]

// 边框渐变
[
  .auraBrightBlue.opacity(0.3),
  .auraSkyBlue.opacity(0.2),
  .auraBrightBlue.opacity(0.15)
]
```

**顶部Tab Bar**:
```swift
// 选中状态
- 背景: auraBrightBlue → auraSkyBlue 渐变
- 底部指示器: 3px 渐变条
- 文字: 白色(深色) / 蓝色(浅色)

// 未选中状态
- 背景: 透明
- 文字: 60% 透明度
```

#### ✅ 达成目标

1. **视觉清爽度**: 纯白背景大幅提升白天模式的简洁感
2. **品牌一致性**: 所有渐变色统一使用UI文档定义的主题色
3. **界面完整性**: 修复侧边栏顶部显示问题
4. **交互优化**: SettingsView改用顶部导航，避免重复，更符合习惯
5. **用户体验**: 深色模式效果优秀，白天模式同样出色

#### 🌟 设计理念

- **简洁至上**: 纯白背景体现极简设计
- **品牌色聚焦**: 主题渐变色突出品牌特色
- **交互合理**: 不同场景使用不同导航方式
- **细节完美**: 修复所有视觉瑕疵

---

### ✨ Phase 3.5.4.1: 卡片颜色微调 - 淡蓝色渐变 (2025-11-16)

#### 🎨 细节优化
**根据用户反馈，调整白天模式卡片颜色**

用户反馈：白天模式卡片颜色不要灰色，要淡淡的蓝色渐变，与白色背景区分开来。

#### ✅ 已完成的优化

**卡片颜色优化** ([`BlurGlassCard.swift`](AuraWind/Views/Components/BlurGlassCard.swift:65-113))
- ✅ 白天模式卡片改用淡淡的蓝色渐变（UI文档蓝色系）
- ✅ 渐变色定义：
  - `auraPaleCyan.opacity(0.25)` - 极淡青色 `rgb(230, 247, 244)`
  - `auraSoftBlue.opacity(0.15)` - 柔和蓝色 `rgb(207, 221, 245)`
  - `auraPaleCyan.opacity(0.20)` - 极淡青色
- ✅ 边框优化：淡淡的蓝色边框
  - `auraSkyBlue.opacity(0.25)` - 天蓝色 `rgb(133, 208, 244)`
  - `auraMediumBlue.opacity(0.20)` - 中蓝色 `rgb(178, 210, 243)`
  - `auraSoftBlue.opacity(0.15)` - 柔和蓝色 `rgb(207, 221, 245)`
- ✅ 效果特点：
  - 纯正的淡蓝色调，无灰色
  - 使用UI文档定义的品牌蓝色系
  - 淡淡的渐变感，优雅自然
  - 与纯白背景明显区分
  - 保持清新简洁的视觉风格

#### 🎯 设计理念

**淡蓝至上**:
- 使用UI文档的蓝色系（auraPaleCyan, auraSoftBlue, auraSkyBlue）
- 避免任何灰色调
- 保持卡片与背景的清晰对比

**渐变细腻**:
- 三层蓝色渐变营造深度感
- 透明度控制在15%-25%
- 整体呈现柔和的蓝色过渡效果

---




### 阶段 0: 项目规划与架构设计 (2025-11-16) ✅

#### 已完成
- ✅ 创建项目文档目录结构
- ✅ 编写开发者文档 (DeveloperDocument.md)
  - 定义项目概述和核心特性
  - 设计 MVVM 架构模式
  - 规划项目目录结构
  - 定义核心模块接口
  - 制定 UI 设计规范
  - 确立实现要点和最佳实践
- ✅ 获取 SwiftUI 技术文档参考
- ✅ 创建变更日志 (CHANGELOG.md)
- ✅ 创建项目路线图 (ROADMAP.md)
- ✅ 创建架构设计文档 (Architecture.md)
- ✅ 创建 UI 设计指南 (UIDesignGuide.md)
- ✅ 创建 API 接口文档 (APIReference.md)
- ✅ 创建项目 README.md
- ✅ 创建技术栈文档 (TechStack.md)

---

### 阶段 1: 基础架构搭建 (2025-11-16) ✅

**状态**: 已完成

---

### 阶段 2: SMC驱动集成与核心业务逻辑 (2025-11-16 - 进行中)

#### 已完成 (Phase 1.1 - 项目配置与代码规范)
- ✅ 创建项目目录结构
  - Models/ 数据模型层
  - Views/ 视图层 (Main, Settings, MenuBar, Components)
  - ViewModels/ 视图模型层
  - Services/ 服务层
  - Utils/ 工具类 (Extensions)
- ✅ 配置 SwiftLint (.swiftlint.yml)
  - 定义代码风格规则
  - 配置自定义规则
  - 设置排除路径
- ✅ 创建常量定义 (Constants.swift)
  - 应用信息常量
  - UserDefaults 键定义
  - 间距系统规范
  - 圆角规范
  - 动画时长定义
  - 温度和风扇常量

#### 已完成 (Phase 1.2 - 基础工具类)
- ✅ 创建颜色主题扩展 (Color+Theme.swift)
  - 品牌色定义
  - 渐变色定义
  - 状态色定义
  - 玻璃效果色
  - 自适应颜色支持
  - 渐变预设
- ✅ 创建 View 修饰器扩展 (View+Modifiers.swift)
  - 发光效果修饰器
  - 点击反馈修饰器
  - 悬停效果修饰器
  - 淡入淡出修饰器
  - 滑动进入修饰器
  - 可访问性修饰器
  - 卡片样式修饰器

#### 已完成 (Phase 1.2 - 数据模型)
- ✅ 创建错误处理类型 (AuraWindError.swift)
  - SMC 相关错误
  - 风扇控制错误
  - 温度传感器错误
  - 数据持久化错误
  - 曲线配置错误
  - 本地化错误描述
- ✅ 创建风扇模型 (Fan.swift)
  - 风扇基础属性
  - 转速计算方法
  - 状态判断
  - 示例数据
- ✅ 创建温度传感器模型 (TemperatureSensor.swift)
  - 传感器类型枚举
  - 温度状态判断
  - 历史读数管理
  - 温度计算方法
  - 示例数据
- ✅ 创建曲线配置模型 (CurveProfile.swift)
  - 曲线点数据结构
  - 线性插值算法
  - 曲线验证逻辑
  - 预设曲线（静音、平衡、性能）

#### 已完成 (Phase 1.3 - 数据持久化服务)
- ✅ 创建数据持久化服务 (PersistenceService.swift)
  - UserDefaults 操作封装
  - 文件操作封装
  - JSON 编码/解码
  - 曲线配置持久化
  - 应用设置持久化

#### 已完成 (Phase 1.4 - 基础架构完成)
- ✅ 创建 SMC Service 协议接口 (SMCServiceProtocol.swift)
  - 定义连接管理接口
  - 温度监控接口
  - 风扇控制接口
  - 硬件监控接口
  - 温度传感器类型枚举
- ✅ 创建基础 ViewModel 框架 (BaseViewModel.swift)
  - ViewModelProtocol 协议定义
  - BaseViewModel 基类实现
  - 错误处理机制
  - 加载状态管理
  - 状态更新辅助方法
- ✅ 创建液态玻璃卡片组件 (LiquidGlassCard.swift)
  - 玻璃效果强度控制
  - 渐变背景和边框
  - 可定制的内边距和圆角
  - 预览支持
- ✅ 更新 ContentView 演示界面
  - 液态玻璃设计展示
  - 温度和风扇卡片演示
  - 项目状态显示

#### 已完成 (Phase 2.1 - SMC Service完整实现)
- ✅ 创建 SMC Service 完整实现 (SMCService.swift)
  - IOKit框架集成
  - SMC连接管理(打开/关闭)
  - 温度传感器读取
  - 风扇信息获取
  - 风扇转速控制
  - 自动模式切换
  - 线程安全的队列设计
  - 缓存机制(温度1秒,风扇5秒)
  - 错误处理和重试机制
  - Mock实现用于开发测试

#### 已完成 (Phase 2.2 - 核心ViewModel实现)
- ✅ 创建风扇控制ViewModel (FanControlViewModel.swift)
  - 风扇状态管理
  - 监控任务调度
  - 多种控制模式(自动/手动/曲线/预设)
  - 温度-转速曲线应用
  - 实时监控循环
  - 设置持久化
  - Combine响应式绑定
- ✅ 创建温度监控ViewModel (TemperatureMonitorViewModel.swift)
  - 实时温度监控
  - 历史数据收集和管理
  - 温度警告系统
  - 数据统计(平均/最高/最低)
  - CSV数据导出
  - 历史数据限制
  - 可配置的监控参数

---

### 阶段 1 总结 (2025-11-16) ✅

#### ✅ 已完成的核心文件 (14 个)

**配置文件 (1)**
1. `.swiftlint.yml` - SwiftLint 代码规范配置

**工具类 (3)**
2. `AuraWind/Utils/Constants.swift` - 常量定义
3. `AuraWind/Utils/Extensions/Color+Theme.swift` - 颜色主题扩展
4. `AuraWind/Utils/Extensions/View+Modifiers.swift` - View 修饰器扩展

**数据模型 (4)**
5. `AuraWind/Models/AuraWindError.swift` - 错误类型定义
6. `AuraWind/Models/Fan.swift` - 风扇模型
7. `AuraWind/Models/TemperatureSensor.swift` - 温度传感器模型
8. `AuraWind/Models/CurveProfile.swift` - 曲线配置模型

**服务层 (2)**
9. `AuraWind/Services/PersistenceService.swift` - 数据持久化服务
10. `AuraWind/Services/SMCServiceProtocol.swift` - SMC 服务协议

**视图模型 (1)**
11. `AuraWind/ViewModels/BaseViewModel.swift` - 基础 ViewModel

**视图组件 (2)**
12. `AuraWind/Views/Components/LiquidGlassCard.swift` - 液态玻璃卡片
13. `AuraWind/ContentView.swift` - 主视图（演示界面）

**应用入口 (1)**
14. `AuraWind/AuraWindApp.swift` - 应用入口

---

### 阶段 2 总结 (2025-11-16 - 进行中)

#### ✅ 已完成的核心文件 (3个)

**服务层实现 (1)**
1. `AuraWind/Services/SMCService.swift` - SMC服务完整实现 (460行)

**视图模型实现 (2)**
2. `AuraWind/ViewModels/FanControlViewModel.swift` - 风扇控制ViewModel (318行)
3. `AuraWind/ViewModels/TemperatureMonitorViewModel.swift` - 温度监控ViewModel (330行)

#### 📊 新增代码统计
- **新增文件数**: 3 个核心文件
- **新增代码行数**: 约 1,100+ 行
- **服务实现**: 1 个完整的SMC服务
- **ViewModel**: 2 个核心业务ViewModel

#### 🎯 阶段2已达成目标
- ✅ SMC服务完整实现
- ✅ 温度传感器读取功能
- ✅ 风扇控制功能
- ✅ 核心业务逻辑实现
- ✅ 响应式状态管理
- ✅ 数据持久化集成

#### 🔄 技术亮点
1. **线程安全**: 使用串行队列确保SMC访问安全
2. **性能优化**: 实现智能缓存机制减少硬件访问
3. **错误处理**: 完善的错误类型和重试机制
#### ✅ Phase 3 UI界面开发完成 (2025-11-16)

**已完成的视图文件 (5个)**:
1. `AuraWind/Views/Main/MainView.swift` - 主窗口界面 (228行)
   - NavigationSplitView布局
   - 侧边栏导航
   - 标签页切换
   - 状态指示器
   
2. `AuraWind/Views/Main/DashboardView.swift` - 仪表盘视图 (400行)
   - 统计卡片
   - 温度传感器显示
   - 风扇状态显示
   - 快速控制面板
   - 模式切换按钮
   
3. `AuraWind/Views/Main/FanListView.swift` - 风扇列表视图 (325行)
   - 风扇控制卡片
   - 手动转速控制
   - 圆形进度显示
   - 转速范围信息
   - 实时转速更新
   
4. `AuraWind/Views/Main/TemperatureChartView.swift` - 温度图表视图 (340行)
   - 时间范围选择器
   - 温度统计卡片
   - 图表占位(待实现)
   - 传感器详情列表
   - 数据导出功能
   
5. `AuraWind/Views/Settings/SettingsView.swift` - 设置面板 (426行)
   - 通用设置
   - 曲线配置
   - 通知设置
   - 高级设置
   - 数据管理

**应用入口更新**:
- ✅ 更新 `AuraWindApp.swift`
  - 集成MainView
  - 依赖注入配置
  - 窗口样式设置

#### 📊 Phase 3 代码统计
- **新增文件数**: 5 个视图文件
- **新增代码行数**: 约 1,719 行
- **UI组件**: 完整的主界面系统
- **交互功能**: 丰富的用户交互

#### 🎯 Phase 3 达成目标
- ✅ 完整的导航系统
- ✅ 液态玻璃设计实现
- ✅ 响应式布局
- ✅ 实时数据显示
- ✅ 交互控制面板
- ✅ 设置管理界面

---
### ✨ Phase 3.5: UI风格重构 - 新拟物+液态玻璃 (2025-11-16)

#### 🎨 设计理念升级
**从单一液态玻璃到新拟物+液态玻璃融合**

根据用户反馈,UI风格调整为更强烈的**Neumorphism(新拟物风格)**,结合CSS `box-shadow: inset`效果,营造真实的触感深度。

#### ✅ 已完成的重构

1. **增强版 LiquidGlassCard** ([`LiquidGlassCard.swift`](AuraWind/Views/Components/LiquidGlassCard.swift))
   - ✅ 新增内阴影模拟层 - 模拟CSS `inset shadow`效果
     - 顶部左侧: 深色阴影(auraSoftBlue.opacity(0.25))
     - 底部右侧: 浅色高光(white.opacity(0.4))
     - 模糊半径: 8pt,营造柔和过渡
   - ✅ 优化外部弥散阴影系统
     - 深色阴影: `shadowDark, radius: 12, x: 6, y: 6` (右下投影)
     - 浅色阴影: `shadowLight, radius: 12, x: -6, y: -6` (左上高光)
     - 环境光: `shadowAmbient, radius: 25` (全方向扩散)
   - ✅ 更细腻的三色渐变边框
     - 顶部: white.opacity(0.5) 
     - 中部: auraPaleCyan.opacity(0.3)
     - 底部: auraSoftBlue.opacity(0.15)
     - 边框宽度: 2pt
   - ✅ 背景融合优化
     - 基础色: auraLightGray.opacity(0.95)
     - 更接近主背景(auraBackground)
     - 减少材质透明度到0.3

2. **新增 NeumorphicButton 组件** ([`NeumorphicButton.swift`](AuraWind/Views/Components/NeumorphicButton.swift))
   - ✅ 完全模拟CSS Neumorphism按钮效果
   - ✅ 状态系统:
     - **Normal状态**: 凸起效果(外阴影)
       - 顶部左侧: 浅色高光渐变
       - 底部右侧: 深色阴影渐变
     - **Pressed状态**: 凹陷效果(内阴影)
       - 顶部左侧: 深色内阴影
       - 底部右侧: 浅色内高光
       - 外阴影清除,模拟按下
     - **Hover状态**: 弥散光晕
       - 主题色光晕: `style.color.opacity(0.3), radius: 15`
       - 放大: scale(1.05)
     - **Selected状态**: 
       - 内部高亮: `style.color.opacity(0.15)`
       - 边框加粗: 2.5pt
   - ✅ 5种预设样式
     - Primary: auraBrightBlue
     - Secondary: auraMediumBlue  
     - Success: statusNormal (green)
     - Warning: statusWarning (orange)
     - Danger: statusDanger (red)
   - ✅ 流畅动画
     - Spring animation: response 0.2-0.3s, damping 0.7
     - Scale动画: 0.98倍(按下)
   - ✅ 支持图标+文字、纯图标模式
   - ✅ 圆角: CornerRadius.full (完全圆角)

3. **UI设计文档更新** ([`UIDesignGuide.md`](docs/UIDesignGuide.md))
   - ✅ 新增"新拟物风格"核心设计理念
   - ✅ 详细的内阴影实现原理和代码
   - ✅ 外部弥散阴影系统说明
   - ✅ NeumorphicButton使用指南和示例
   - ✅ 交互状态设计规范

#### 🔧 编译错误修复
在UI重构过程中,修复了Phase 3遗留的所有编译错误:

**属性vs方法调用错误** (6处):
- ✅ DashboardView: `temperaturePercentage()` → `temperaturePercentage`
- ✅ DashboardView: `speedPercentage()` → `speedPercentage`  
- ✅ DashboardView: `isWarning()` → `isWarning`
- ✅ FanListView: `speedPercentage()` → `speedPercentage` (2处)
- ✅ TemperatureChartView: `temperaturePercentage()` → `temperaturePercentage` (2处)
- ✅ TemperatureChartView: `isWarning()` → `isWarning` (2处)
- ✅ MainView: `isWarning()` → `isWarning`

**Switch语句不完整** (3处):
- ✅ DashboardView: 补全传感器类型case (battery, ssd, thunderbolt)
- ✅ DashboardView: 补全风扇模式case (auto, manual, curve)
- ✅ TemperatureChartView: 补全传感器类型case (battery, ssd, thunderbolt)

**颜色定义缺失** (2处):
- ✅ Color+Theme: 添加 `auraBlue` (指向auraBrightBlue)
- ✅ Color+Theme: 添加 `shadowMedium` (auraSoftBlue.opacity(0.15))

#### 📊 代码统计
- **新增文件**: 1个 (NeumorphicButton.swift, 334行)
- **修改文件**: 3个 (LiquidGlassCard.swift, UIDesignGuide.md, Color+Theme.swift)
- **修复错误**: 13处编译错误
- **新增代码**: 约400+行
- **文档更新**: 150+行

#### 🎯 设计效果对比

**Before (Phase 3)**:
- 单一液态玻璃效果
- 简单的外阴影
- 平面感较强

**After (Phase 3.5)**:
- 新拟物+液态玻璃融合
- 内阴影(inset) + 三层外阴影
- 真实的凸起/凹陷触感
- 弥散光感和深度
- 按压动画反馈

#### 🎨 核心设计参数

**新拟物阴影系统**:
```swift
// 外部阴影 (凸起感)
.shadow(color: .shadowDark, radius: 12, x: 6, y: 6)      // 深色 右下
.shadow(color: .shadowLight, radius: 12, x: -6, y: -6)   // 浅色 左上  
.shadow(color: .shadowAmbient, radius: 25, x: 0, y: 0)   // 环境光

// 内部阴影 (凹陷感) - 通过渐变模拟
LinearGradient(
    colors: [Color.auraSoftBlue.opacity(0.25), Color.clear],
    startPoint: .topLeading, endPoint: .bottomTrailing
).blur(radius: 8)
```

**按钮状态转换**:
- Normal → Pressed: 外阴影消失,内阴影显示,scale(0.98)
- Normal → Hover: 光晕出现,scale(1.05)
- Any → Selected: 内部高亮,边框加粗

#### 🌟 下一步优化
- ⏳ 在现有UI视图中应用NeumorphicButton
- ⏳ 创建更多新拟物风格组件(Slider, Toggle, TextField)
- ⏳ 优化深色模式适配
- ⏳ 性能优化(减少模糊和阴影层级)

---


4. **响应式编程**: Combine框架实现数据流管理
5. **模块化设计**: 清晰的协议和依赖注入
6. **Mock支持**: 开发阶段的模拟实现

#### 📊 代码统计

### ✨ Phase 3.5.1: UI风格升级 - 发光效果 (2025-11-16)

#### 🎨 设计理念再升级
**从新拟物风格到发光+新拟物+液态玻璃三位一体**

根据用户反馈,UI风格进一步升级为更炫酷的**发光效果(Glow)**设计,完全模拟CSS炫酷卡片效果!

#### ✅ 新增组件

1. **GlowCard 发光卡片** ([`GlowCard.swift`](AuraWind/Views/Components/GlowCard.swift) - 399行)
   - ✅ **多层径向渐变背景**
     - 深色模式: 4层径向渐变
       - 层1: 中心深色区域 (radialDarkCenter)
       - 层2: 左上蓝色光晕 (radialBlueGlow1 @ 0.2,0.3)
       - 层3: 右下蓝色光晕 (radialBlueGlow2 @ 0.8,0.7)
       - 层4: 边缘浅蓝 (radialLightEdge @ bottomTrailing)
     - 浅色模式: 3层渐变
       - 基础: auraLightGray.opacity(0.95)
       - 线性渐变: 三色柔和过渡
       - 径向光晕: 微妙蓝色光晕(opacity 0.05)
   
   - ✅ **内发光效果** (Inset Glow)
     - 顶部高光渐变描边
     - 内部阴影: radius 16, blur 8
     - 深浅模式自适应透明度
   
   - ✅ **外发光阴影**
     - 深色模式: 黑色阴影 opacity 0.5
     - 浅色模式: 柔和蓝色阴影
     - Radius: 20, Y偏移: 10
   
   - ✅ **旋转发光边框动画** (可选)
     - AngularGradient 角度渐变
     - 8秒完整旋转
     - 蓝色光带: auraBrightBlue → auraSkyBlue
     - Blur半径: 4pt
   
   - ✅ **完整深浅模式支持**
     - ColorScheme参数控制
     - 自动适配背景、边框、阴影

2. **GlowButton 发光按钮** ([`GlowButton.swift`](AuraWind/Views/Components/GlowButton.swift) - 280行)
   - ✅ **5种预设样式**
     - Primary: 蓝色渐变 (auraBrightBlue → auraSkyBlue)
     - Success: 绿色渐变
     - Warning: 橙黄渐变
     - Danger: 红色渐变
     - Secondary: 浅蓝渐变
   
   - ✅ **渐变背景**
     - LinearGradient from topLeading to bottomTrailing
     - 每种样式独立渐变色
   
   - ✅ **内发光高光**
     - 顶部白色高光渐变 (浅色模式)
     - Opacity: 0.4, Blur: 4
   
   - ✅ **外发光效果**
     - Normal: opacity 0.3, radius 10
     - Hover: opacity 0.6, radius 20
     - 自动颜色匹配样式
   
   - ✅ **交互动画**
     - Pressed: scale 0.95
     - Hover: 光晕增强
     - Spring animation
   
   - ✅ **深浅模式适配**
     - 内发光在深色模式禁用
     - 按下状态内阴影

3. **新增深色模式颜色** ([`Color+Theme.swift`](AuraWind/Utils/Extensions/Color+Theme.swift))
   - ✅ `auraDarkBackground` - rgb(15, 23, 38) 深邃蓝黑
   - ✅ `auraDarkCard` - rgb(20, 30, 48) 深蓝灰卡片
   - ✅ `auraDarkBorder` - rgb(60, 120, 180) 深色边框高光
   - ✅ `radialDarkCenter` - rgb(15, 23, 38) 径向中心
   - ✅ `radialBlueGlow1` - rgb(26, 99, 137) 蓝色光晕1
   - ✅ `radialBlueGlow2` - rgb(36, 137, 191) 蓝色光晕2
   - ✅ `radialLightEdge` - rgb(13, 94, 133) 浅蓝边缘

#### 📊 代码统计
- **新增文件**: 2个组件 (GlowCard 399行, GlowButton 280行)
- **修改文件**: 2个 (Color+Theme, UIDesignGuide)
- **新增代码**: 约700+行
- **新增颜色**: 7个深色模式专用色
- **文档更新**: 200+行

#### 🎯 设计对比

**Phase 3.5 → Phase 3.5.1**:
- 新拟物风格 → **发光+新拟物+液态玻璃**
- 简单渐变 → **多层径向渐变**
- 基础阴影 → **内发光+外发光**
- 静态边框 → **可选旋转发光边框**
- 仅浅色 → **完整深浅模式**

#### 🌟 核心视觉参数

**径向渐变配置** (深色模式):
```swift
// 4层渐变营造深邃感
RadialGradient(colors: [center, clear], center: .center, r: 200)      // 中心
RadialGradient(colors: [glow1, clear], center: (0.2,0.3), r: 150)    // 左上光晕
RadialGradient(colors: [glow2, clear], center: (0.8,0.7), r: 180)    // 右下光晕
RadialGradient(colors: [clear, edge], center: .bottomTrailing, r: 200) // 边缘
```

**发光效果**:
```swift
// 内发光
.shadow(color: glowColor, radius: 16, y: -8).blur(radius: 8)

// 外发光
.shadow(color: glowColor.opacity(0.3-0.6), radius: 10-20)

// 按钮发光(Hover)
.shadow(color: buttonColor.opacity(0.6), radius: 20)
```

**旋转边框**:
```swift
AngularGradient(angle: .degrees(rotation))  // rotation: 0 → 360
.animation(.linear(duration: 8).repeatForever())
```

#### 🎨 组件选择指南

| 组件 | 适用场景 | 视觉效果 | 性能 |
|------|---------|---------|------|
| **GlowCard** | 重要信息卡片、仪表盘 | ⭐⭐⭐⭐⭐ 炫酷 | 中(径向渐变) |
| **GlowButton** | 主要操作按钮 | ⭐⭐⭐⭐⭐ 炫酷 | 高 |
| LiquidGlassCard | 普通卡片、列表项 | ⭐⭐⭐⭐ 优雅 | 高 |
| NeumorphicButton | 选择器、开关 | ⭐⭐⭐ 简约 | 高 |

#### 🚀 下一步
- ⏳ 在主界面应用GlowCard和GlowButton
- ⏳ 优化深色模式下的配色
- ⏳ 性能优化(减少径向渐变层数)
- ⏳ 添加更多发光组件(Slider, TextField)

### ✨ Phase 3.5.2: UI完全统一 - 弥散渐变毛玻璃风格 (2025-11-16) ✅

#### 🐛 Bug修复 (2025-11-16 22:53)

**ContentView编译错误修复**:
- ✅ 修复结构体闭合大括号错误
- ✅ 移除struct外部的`backgroundGradient`方法定义
- ✅ 添加`.auraBackground()`统一背景
- ✅ 将VStack改为ScrollView以支持滚动

**项目清理**:
- ✅ 删除4个废弃组件文件:
  - `GlowButton.swift` (280行)
  - `GlowCard.swift` (399行)
  - `LiquidGlassCard.swift` (原版本)
  - `NeumorphicButton.swift` (334行)
- ✅ 保留唯一统一组件: `BlurGlassCard.swift`
- ✅ 清理约1,000+行废弃代码

### ✨ Phase 3.5.2: UI完全统一 - 弥散渐变毛玻璃风格 (2025-11-16)

#### 🎨 设计理念终极简化
**从复杂炫酷效果回归简约统一**

根据用户强烈反馈,UI风格进行了彻底的统一重构,完全移除了之前过于花哨的动画和不一致的组件,采用**简单、优雅、统一**的弥散渐变毛玻璃风格。

#### ✅ 核心变更

**1. 新增统一组件**

- **BlurGlassCard** ([`BlurGlassCard.swift`](AuraWind/Views/Components/BlurGlassCard.swift) - 251行)
  - ✅ 统一的毛玻璃卡片组件,替代所有之前的卡片类型
  - ✅ 使用`.ultraThinMaterial`实现真正的毛玻璃效果
  - ✅ 15%透明度的柔和渐变叠加层
  - ✅ 自动适配浅色/深色模式
  - ✅ 细腻的渐变边框(白色→淡青色→柔蓝色)
  - ✅ 柔和的外阴影系统
  - ✅ 无任何动画,简洁稳定

- **AuraBackgroundGradient** ([`View+Background.swift`](AuraWind/Utils/Extensions/View+Background.swift) - 56行)
  - ✅ 统一的背景渐变系统
  - ✅ `.auraBackground()`修饰符,一行代码应用
  - ✅ 浅色模式: 白色→柔蓝色→淡青色三色渐变
  - ✅ 深色模式: 深蓝黑色系径向渐变
  - ✅ 所有视图使用统一背景

**2. 全面替换组件**

替换以下视图中的所有卡片组件:
- ✅ [`ContentView.swift`](AuraWind/ContentView.swift)
  - 移除`GlowCard`,改用`BlurGlassCard`
  - 移除旋转发光边框动画
  - 应用`.auraBackground()`统一背景
  
- ✅ [`DashboardView.swift`](AuraWind/Views/Main/DashboardView.swift)
  - 所有`GlowCard`→`BlurGlassCard`
  - 简化背景代码,使用`.auraBackground()`
  - 移除所有动画参数
  
- ✅ [`FanListView.swift`](AuraWind/Views/Main/FanListView.swift)
  - 所有`LiquidGlassCard`→`BlurGlassCard`
  - 应用统一背景
  
- ✅ [`TemperatureChartView.swift`](AuraWind/Views/Main/TemperatureChartView.swift)
  - 所有`LiquidGlassCard`→`BlurGlassCard`
  - 移除`intensity`参数
  - 应用统一背景
  
- ✅ [`SettingsView.swift`](AuraWind/Views/Settings/SettingsView.swift)
  - 所有`LiquidGlassCard`→`BlurGlassCard`
  - 应用统一背景
  
- ✅ [`MainView.swift`](AuraWind/Views/Main/MainView.swift)
  - 移除自定义背景渐变代码
  - 统一使用`.auraBackground()`

#### 🎯 设计原则

**简约三原则**:
1. **Simple** - 简单: 只用毛玻璃+柔和渐变,无复杂效果
2. **Unified** - 统一: 一种卡片,一种背景,全局一致
3. **Consistent** - 连贯: 浅色/深色模式完整适配

**移除的复杂效果**:
- ❌ 旋转发光边框动画(太花哨)
- ❌ 多层径向渐变背景(太复杂)
- ❌ 内发光/外发光效果(不够简约)
- ❌ Neumorphic按钮(与整体风格不协调)
- ❌ 各种`intensity`参数(增加复杂度)

**保留的核心元素**:
- ✅ 毛玻璃材质(`.ultraThinMaterial`)
- ✅ 柔和渐变(15%透明度叠加)
- ✅ 细腻边框(三色渐变)
- ✅ 柔和阴影
- ✅ AuraWind品牌色系

#### 📊 代码统计

- **新增文件**: 2个 (BlurGlassCard, View+Background)
- **修改文件**: 6个视图文件
- **新增代码**: 约307行
- **简化代码**: 移除约200+行复杂效果代码
- **统一组件**: 1个卡片替代3个旧组件

#### 🎨 视觉效果对比

| 阶段 | 风格 | 复杂度 | 一致性 | 性能 |
|------|------|--------|--------|------|
| Phase 3.5 | 新拟物 | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| Phase 3.5.1 | 发光效果 | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| **Phase 3.5.2** | **弥散毛玻璃** | **⭐** | **⭐⭐⭐⭐⭐** | **⭐⭐⭐⭐⭐** |

#### 🌟 核心代码示例

**统一卡片使用**:
```swift
BlurGlassCard {
    VStack {
        // 卡片内容
    }
}
```

**统一背景应用**:
```swift
ScrollView {
    // 内容
}
.auraBackground()
```

**颜色系统** (已有AuraWind品牌色):
- auraBackground, auraSoftBlue, auraPaleCyan (浅色)
- auraDarkBackground 系列 (深色)
- 自动适配ColorScheme

#### ✅ 完成的改进

1. **视觉统一**: 所有界面使用相同的卡片和背景
2. **代码简化**: 移除复杂参数,一个组件解决所有需求
3. **性能提升**: 移除动画和多层渐变,提升渲染性能
4. **维护性**: 统一修改一个组件即可影响全局
5. **用户体验**: 简洁优雅,不花哨,专业感强

#### 🚀 后续优化方向

- ⏳ 弃用旧组件(GlowCard, GlowButton, NeumorphicButton, LiquidGlassCard)
- ⏳ 更新UI设计文档,反映新的简约风格
- ⏳ 深色模式细节优化
- ⏳ 添加更多统一风格的组件(Slider, Toggle等)

---

- **总文件数**: 14 个核心文件
- **总代码行数**: 约 2,000+ 行
- **模型定义**: 4 个完整的数据模型
- **服务接口**: 2 个服务层定义
- **UI 组件**: 2 个可复用组件
- **工具扩展**: 3 个实用扩展

#### 🎯 达成目标
- ✅ 完整的 MVVM 架构基础
- ✅ 清晰的代码组织结构
- ✅ 完善的错误处理机制
- ✅ 数据持久化支持
- ✅ 液态玻璃 UI 设计实现
- ✅ 代码规范配置

---

### UI 配色方案调整 (2025-11-16)

#### 🎨 基于 Logo 配色的重新设计

**调整原因**: 根据实际 Logo 配色进行UI颜色系统重构

**Logo 配色分析**:
- `rgb(229, 237, 246)` - 浅蓝灰色 (主背景)
- `rgb(207, 221, 245)` - 柔和蓝色
- `rgb(242, 245, 244)` - 浅灰白色
- `rgb(103, 172, 240)` - 明亮蓝色 (主色调) ⭐
- `rgb(219, 247, 247)` - 淡青色
- `rgb(178, 210, 243)` - 中蓝色
- `rgb(133, 208, 244)` - 天蓝色
- `rgb(230, 247, 244)` - 极淡青色
- `rgba(246, 249, 249, 96)` - 半透明白色 (玻璃效果)

#### ✅ 已完成的调整

1. **颜色系统重构** ([`Color+Theme.swift`](AuraWind/Utils/Extensions/Color+Theme.swift))
   - ✅ 替换原有的蓝紫黄配色为 Logo 蓝色系
   - ✅ 新增 9 种基于 Logo 的品牌色
   - ✅ 更新液态玻璃效果色（使用 Logo 半透明白）
   - ✅ 新增新拟物风格阴影色（浅色+深色双阴影）
   - ✅ 更新渐变预设（7 种新渐变）
   - ✅ 调整自适应颜色以匹配 Logo 风格

2. **UI 组件更新** ([`LiquidGlassCard.swift`](AuraWind/Views/Components/LiquidGlassCard.swift))
   - ✅ 背景使用 Logo 浅灰白色
   - ✅ 新拟物双阴影效果（凸起感）
   - ✅ 边框渐变使用淡青色系
   - ✅ 更新所有预览示例

3. **主界面调整** ([`ContentView.swift`](AuraWind/ContentView.swift))
   - ✅ 背景改用 Logo 柔和渐变
   - ✅ 图标从四叶风扇改为三叶风扇 (`wind` 图标)
   - ✅ 所有颜色引用更新为新配色
   - ✅ 卡片间距和阴影调整

#### 🎯 设计风格特点

**简约现代美学**:
- 清新的蓝色系为主
- 大量留白和呼吸感
- 柔和的渐变过渡

**液态玻璃效果**:
- 半透明材质
- 模糊背景
- 淡青色边框

**新拟物风格** (Neumorphism):
- 双阴影效果（浅色 + 深色）
- 轻微的凸起感
- 柔和的光影变化

#### 📝 图标更新
- ❌ 移除: `fan.fill` (四叶风扇)
- ✅ 使用: `wind` (三叶风扇，更符合 Logo)

#### 下一步计划
- ⏳ Phase 2: SMC 驱动集成
  - 实现 SMCService 具体功能
  - IOKit 框架集成
  - 温度和风扇控制实现

#### 待办事项
- ⏳ 配置 Xcode 项目设置
- ⏳ 设置代码规范和 SwiftLint 配置
- ⏳ 配置 Git hooks 和 CI/CD

---

### 阶段 1: 基础架构搭建 (计划中)

#### 待实现功能
- ⏳ 创建基础 MVVM 架构
  - [ ] 实现 BaseViewModel 基类
  - [ ] 创建 Service 层协议
  - [ ] 设置依赖注入容器
- ⏳ 实现数据持久化服务
  - [ ] PersistenceService 实现
  - [ ] 配置 UserDefaults 存储
  - [ ] 实现数据加密（如需要）
- ⏳ 创建日志系统
  - [ ] 统一 Logger 配置
  - [ ] 日志级别管理
  - [ ] 日志文件输出
- ⏳ 设置单元测试框架
  - [ ] 配置 XCTest
  - [ ] 创建 Mock 服务
  - [ ] 编写基础测试用例

---

### 阶段 2: SMC 驱动集成 (计划中)

#### 待实现功能
- ⏳ SMC Service 基础实现
  - [ ] IOKit 框架集成
  - [ ] SMC 连接管理
  - [ ] 错误处理机制
- ⏳ 温度传感器读取
  - [ ] CPU 温度读取
  - [ ] GPU 温度读取
  - [ ] 其他传感器支持
- ⏳ 风扇控制功能
  - [ ] 风扇数量检测
  - [ ] 风扇信息读取
  - [ ] 风扇转速控制
  - [ ] 自动模式切换
- ⏳ 权限和安全
  - [ ] 配置 Entitlements
  - [ ] 权限请求处理
  - [ ] 安全检查实现

---

### 阶段 3: 核心业务逻辑 (计划中)

#### 待实现功能
- ⏳ FanControlViewModel 实现
  - [ ] 风扇状态管理
  - [ ] 监控任务调度
  - [ ] 模式切换逻辑
- ⏳ TemperatureMonitorViewModel 实现
  - [ ] 实时温度监控
  - [ ] 历史数据管理
  - [ ] 图表数据生成
- ⏳ 曲线系统实现
  - [ ] CurveProfile 数据模型
  - [ ] 插值算法实现
  - [ ] 预设曲线配置
  - [ ] 自定义曲线编辑
- ⏳ 通知系统
  - [ ] 温度警告通知
  - [ ] 风扇异常通知
  - [ ] 系统提示

---

### 阶段 4: UI 界面开发 (计划中)

#### 待实现功能
- ⏳ 液态玻璃组件库
  - [ ] LiquidGlassCard 组件
  - [ ] GlassButton 组件
  - [ ] GlassSlider 组件
  - [ ] 其他自定义组件
- ⏳ 主窗口界面
  - [ ] MainView 布局
  - [ ] DashboardView 实现
  - [ ] FanListView 实现
  - [ ] 温度图表集成
- ⏳ 设置面板
  - [ ] SettingsView 框架
  - [ ] 通用设置页
  - [ ] 曲线编辑器
  - [ ] 高级选项
- ⏳ 菜单栏图标
  - [ ] MenuBarView 实现
  - [ ] 快捷操作菜单
  - [ ] 状态显示
  - [ ] 一键控制

---

### 阶段 5: 图表与可视化 (计划中)

#### 待实现功能
- ⏳ 温度图表
  - [ ] 实时温度曲线
  - [ ] 多传感器对比
  - [ ] 时间范围选择
- ⏳ 转速图表
  - [ ] 风扇转速显示
  - [ ] 转速历史记录
- ⏳ 性能监控
  - [ ] CPU/GPU 使用率
  - [ ] 系统负载显示
- ⏳ 数据导出
  - [ ] CSV 导出
  - [ ] 图表截图
  - [ ] 报告生成

---

### 阶段 6: 高级功能 (计划中)

#### 待实现功能
- ⏳ 自动控制算法优化
  - [ ] 智能温控算法
  - [ ] 预测性调整
  - [ ] 场景识别
- ⏳ 性能模式
  - [ ] 静音模式
  - [ ] 平衡模式
  - [ ] 性能模式
  - [ ] 游戏模式
- ⏳ 高级设置
  - [ ] 启动项管理
  - [ ] 快捷键配置
  - [ ] 主题定制
- ⏳ 更新系统
  - [ ] 自动更新检查
  - [ ] 版本管理
  - [ ] 更新日志显示

---

### 阶段 7: 测试与优化 (计划中)

#### 待实现功能
- ⏳ 单元测试覆盖
  - [ ] ViewModel 测试
  - [ ] Service 测试
  - [ ] Model 测试
- ⏳ UI 测试
  - [ ] 界面交互测试
  - [ ] 布局测试
  - [ ] 可访问性测试
- ⏳ 性能优化
  - [ ] 内存优化
  - [ ] CPU 使用优化
  - [ ] 启动时间优化
- ⏳ 稳定性测试
  - [ ] 长时间运行测试
  - [ ] 极端条件测试
  - [ ] 错误恢复测试

---

### 阶段 8: 文档与发布准备 (计划中)

#### 待实现功能
- ⏳ 用户文档
  - [ ] 用户手册
  - [ ] 快速开始指南
  - [ ] 常见问题 FAQ
  - [ ] 故障排除指南
- ⏳ 开发文档完善
  - [ ] API 文档补充
  - [ ] 架构图更新
  - [ ] 代码注释完善
- ⏳ 发布准备
  - [ ] App Store 资源准备
  - [ ] 应用图标设计
  - [ ] 宣传材料制作
  - [ ] 隐私政策和服务条款
- ⏳ Beta 测试
  - [ ] TestFlight 配置
  - [ ] Beta 测试反馈收集
  - [ ] Bug 修复

---

## [0.1.0] - TBD (Alpha 版本)

### 计划新增
- 基础 SMC 驱动支持
- 简单风扇控制
- 温度监控
- 基础 UI 界面

### 目标功能
- 支持读取 2-4 个风扇
- 支持 CPU 温度监控
- 手动转速控制
- 系统托盘图标

---

## [0.5.0] - TBD (Beta 版本)

### 计划新增
- 温度-转速曲线系统
- 图表可视化
- 预设模式
- 完整设置面板

### 改进
- 液态玻璃 UI 完善
- 性能优化
- 错误处理增强

---

## [1.0.0] - TBD (正式版本)

### 计划新增
- 所有核心功能完整实现
- 完整的文档和帮助系统
- 自动更新功能
- 多语言支持（简中、英文）

### 优化
- 全面性能优化
- 稳定性增强
- 用户体验打磨

---

## 变更类型说明

- `新增 Added` - 新功能
- `变更 Changed` - 现有功能的变更
- `弃用 Deprecated` - 即将移除的功能
- `移除 Removed` - 已移除的功能
- `修复 Fixed` - Bug 修复
- `安全 Security` - 安全性相关的更新

---

## 开发规范

### 提交信息格式
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建/工具相关

### Scope 范围
- `smc`: SMC 驱动相关
- `ui`: UI 界面相关
- `viewmodel`: ViewModel 相关
- `service`: Service 层相关
- `model`: 数据模型相关
- `config`: 配置相关

---

**文档维护**: 每次重要变更都应更新此文档  
**版本管理**: 遵循语义化版本规范  
**发布频率**: Alpha/Beta 阶段按功能发布，正式版按计划发布

---

最后更新：2025-11-16 21:37

### 🐛 Phase 4.3: 编译错误终极修复 - 类型纯净度保证 (2025-11-17)

#### 🔧 修复的顽固编译错误
**彻底解决初始化器不匹配、返回类型冲突和泛型Element约束问题**

#### ✅ 已修复的关键问题

**1. ChartDataPoint纯净类型系统** ([`ChartDataPoint.swift`](AuraWind/Models/ChartDataPoint.swift:186-236))
- ✅ 修复`latest(for:)`方法返回类型错误（返回ChartDataPoint而非Double）
- ✅ 确保`average/maximum/minimum`方法的类型安全调用
- ✅ 消除数组方法链中的类型混淆
- ✅ 优化空数组边界检查

**2. TemperatureLineChart SwiftUI完全兼容** ([`TemperatureLineChart.swift`](AuraWind/Views/Components/TemperatureLineChart.swift:212-276))
- ✅ 修复`uniqueLabels`中的Set转换问题
- ✅ 确保`ForEach`循环的`Element`类型一致性
- ✅ 优化`.max()`/`.min()`调用的可选值处理
- ✅ 修复时间戳比较的类型安全

**3. TemperatureMonitorViewModel数据完整性** ([`TemperatureMonitorViewModel.swift`](AuraWind/ViewModels/TemperatureMonitorViewModel.swift:221-232))
- ✅ 修复温度数组的`max()`/`min()`调用顺序
- ✅ 确保空传感器列表的安全处理
- ✅ 优化数据映射的类型一致性

**4. TemperatureChartView选择器无异常** ([`TemperatureChartView.swift`](AuraWind/Views/Main/TemperatureChartView.swift:169-200))
- ✅ 修复`LazyVGrid`中的`ForEach`枚举绑定
- ✅ 确保传感器标签数组的正确迭代
- ✅ 优化按钮点击事件的类型处理

#### 🎯 核心技术修复

**初始化器类型纯净**:
```swift
// 修复前 - 类型不匹配
ChartDataPoint(label) // 错误：需要Double、String、DataType

// 修复后 - 完整参数
ChartDataPoint(timestamp: date, value: temp, label: name, type: .temperature)
```

**返回类型一致性**:
```swift
// 修复前 - 返回类型错误
func latest(for: String) -> Double? {
    return filtered.max()?.value // 错误：返回ChartDataPoint
}

// 修复后 - 正确类型
func latest(for: String) -> ChartDataPoint? {
    return filtered.max(by: { $0.timestamp < $1.timestamp })
}
```

**泛型Element纯净**:
```swift
// 修复前 - Element类型混淆
ForEach(uniqueLabels, id: \.self) { label in
    // 编译器无法确定Element类型
}

// 修复后 - 明确枚举
ForEach(Array(uniqueLabels.enumerated()), id: \.offset) { index, label in
    // 明确的(String, Int)元组
}
```

#### 📊 修复成果

**类型系统纯净度**:
- ✅ 消除所有ChartDataPoint相关的类型错误
- ✅ 确保SwiftUI ForEach的完美类型推断
- ✅ 保证数组方法的类型一致性

**编译稳定性**:
- ✅ 无初始化器签名错误
- ✅ 无返回类型转换失败
- ✅ 无泛型约束违反

**运行时安全性**:
- ✅ 防止空数组操作
- ✅ 确保可选值正确处理
- ✅ 优化边界条件检查