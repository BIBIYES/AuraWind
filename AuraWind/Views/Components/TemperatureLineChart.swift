//
//  TemperatureLineChart.swift
//  AuraWind
//
//  Created by AuraWind Development Team on 2025-11-17.
//

import SwiftUI
import Charts

/// 温度折线图组件
/// 使用Swift Charts展示多传感器温度趋势
struct TemperatureLineChart: View {
    private static let timeFormatterMMDDHHMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter
    }()

    private static let timeFormatterHHMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    private static let timeFormatterHHMMSS: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    
    // MARK: - Properties
    
    /// 图表数据点
    let dataPoints: [ChartDataPoint]
    
    /// 显示模式
    let displayMode: DisplayMode
    
    /// 是否显示图例
    let showLegend: Bool
    
    /// 是否显示网格
    let showGrid: Bool
    
    /// 图表高度
    let height: CGFloat
    
    /// Y轴范围（可选，如果不提供则使用自动范围）
    let yAxisRange: YAxisRange?
    
    /// 范围管理器（可选，用于动态范围管理）
    let rangeManager: ChartRangeManager?
    
    /// 当前配色方案
    @Environment(\.colorScheme) private var colorScheme

    /// 预分组后的序列数据（避免每次重绘重复 filter）
    private let groupedSeries: [(label: String, points: [ChartDataPoint])]

    /// 预计算标签列表
    private let labels: [String]

    /// 每个标签的最新值缓存
    private let latestValueByLabel: [String: Double]

    /// 预计算时间范围
    private let minTimestamp: Date
    private let maxTimestamp: Date
    private let timeSpan: TimeInterval

    /// 预计算值域
    private let minValue: Double?
    private let maxValue: Double?
    
    // MARK: - Initialization
    
    init(
        dataPoints: [ChartDataPoint],
        displayMode: DisplayMode = .line,
        showLegend: Bool = true,
        showGrid: Bool = true,
        height: CGFloat = 300,
        yAxisRange: YAxisRange? = nil,
        rangeManager: ChartRangeManager? = nil
    ) {
        self.dataPoints = dataPoints
        self.displayMode = displayMode
        self.showLegend = showLegend
        self.showGrid = showGrid
        self.height = height
        self.yAxisRange = yAxisRange
        self.rangeManager = rangeManager

        let grouped = Dictionary(grouping: dataPoints, by: \.label)
        let sortedLabels = grouped.keys.sorted()
        self.labels = sortedLabels
        let groupedSeriesLocal = sortedLabels.map { label in
            let points = grouped[label]?.sorted(by: { $0.timestamp < $1.timestamp }) ?? []
            return (label: label, points: points)
        }
        self.groupedSeries = groupedSeriesLocal

        var latestMap: [String: Double] = [:]
        latestMap.reserveCapacity(groupedSeriesLocal.count)
        for series in groupedSeriesLocal {
            if let latest = series.points.last?.value {
                latestMap[series.label] = latest
            }
        }
        self.latestValueByLabel = latestMap

        let timestamps = dataPoints.map(\.timestamp)
        let minTimestampLocal = timestamps.min() ?? Date()
        let maxTimestampLocal = timestamps.max() ?? Date()
        self.minTimestamp = minTimestampLocal
        self.maxTimestamp = maxTimestampLocal
        self.timeSpan = maxTimestampLocal.timeIntervalSince(minTimestampLocal)

        let values = dataPoints.map(\.value)
        self.minValue = values.min()
        self.maxValue = values.max()
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if showLegend && !labels.isEmpty {
                legendView
            }
            
            chartView
                .frame(height: height)
        }
    }
    
    // MARK: - Chart View
    
    @ViewBuilder
    private var chartView: some View {
        if dataPoints.isEmpty {
            emptyStateView
        } else {
            Chart {
                ForEach(groupedSeries, id: \.label) { series in
                    ForEach(series.points, id: \.id) { point in
                        switch displayMode {
                        case .line:
                            LineMark(
                                x: .value("时间", point.timestamp),
                                y: .value("温度", point.value)
                            )
                            .foregroundStyle(by: .value("传感器", series.label))
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            .interpolationMethod(.linear)
                            
                        case .area:
                            AreaMark(
                                x: .value("时间", point.timestamp),
                                y: .value("温度", point.value)
                            )
                            .foregroundStyle(by: .value("传感器", series.label))
                            .opacity(0.3)
                            .interpolationMethod(.linear)
                            
                            LineMark(
                                x: .value("时间", point.timestamp),
                                y: .value("温度", point.value)
                            )
                            .foregroundStyle(by: .value("传感器", series.label))
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            .interpolationMethod(.linear)
                            
                        case .point:
                            PointMark(
                                x: .value("时间", point.timestamp),
                                y: .value("温度", point.value)
                            )
                            .foregroundStyle(by: .value("传感器", series.label))
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: xAxisDesiredTickCount)) { value in
                    if let date = value.as(Date.self) {
                        AxisGridLine(stroke: StrokeStyle(
                            lineWidth: showGrid ? 0.5 : 0,
                            dash: [2, 2]
                        ))
                        .foregroundStyle(gridColor)
                        
                        AxisValueLabel {
                            Text(formatTime(date))
                                .font(.caption2)
                                .foregroundStyle(labelColor)
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine(stroke: StrokeStyle(
                        lineWidth: showGrid ? 0.5 : 0,
                        dash: [2, 2]
                    ))
                    .foregroundStyle(gridColor)
                    
                    AxisValueLabel {
                        if let temp = value.as(Double.self) {
                            Text("\(Int(temp))°C")
                                .font(.caption2)
                                .foregroundStyle(labelColor)
                        }
                    }
                }
            }
            .chartYScale(domain: getYAxisDomain())
            .chartForegroundStyleScale { label in
                colorForLabel(label)
            }
            .chartLegend(showLegend ? .visible : .hidden)
            .chartPlotStyle { plotArea in
                plotArea
                    .background(plotBackgroundColor)
                    .cornerRadius(8)
            }
        }
    }
    
    
    // MARK: - Legend View
    
    private var legendView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(labels, id: \.self) { label in
                    HStack(spacing: 6) {
                        Circle()
                            .fill(colorForLabel(label))
                            .frame(width: 8, height: 8)
                        
                        Text(label)
                            .font(.caption)
                            .foregroundStyle(labelColor)
                        
                        if let latest = latestValue(for: label) {
                            Text(ChartDataPoint.DataType.temperature.formatted(latest))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(colorForLabel(label))
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colorScheme == .dark
                                ? Color.white.opacity(0.05)
                                : Color.black.opacity(0.03))
                    )
                }
            }
        }
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("暂无数据")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("开始监控后将显示温度趋势图")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Helpers
    
    /// 获取标签对应的颜色
    private func colorForLabel(_ label: String) -> Color {
        let index = labels.firstIndex(of: label) ?? 0
        return getColorAtIndex(index)
    }
    
    /// 根据索引获取颜色（简化复杂表达式）
    private func getColorAtIndex(_ index: Int) -> Color {
        let colors = getChartColors()
        return colors[index % colors.count]
    }
    
    /// 获取图表颜色数组
    private func getChartColors() -> [Color] {
        return [
            Color.auraBrightBlue,
            Color.auraSkyBlue,
            Color.auraMediumBlue,
            Color.auraYellow,
            Color.auraPurple,
            Color.statusNormal,
            Color.statusWarning
        ]
    }
    
    /// 获取标签的最新值
    private func latestValue(for label: String) -> Double? {
        latestValueByLabel[label]
    }
    
    /// 格式化时间
    private func formatTime(_ date: Date) -> String {
        guard !dataPoints.isEmpty else { return "" }
        
        if timeSpan > 3600 * 12 {
            return Self.timeFormatterMMDDHHMM.string(from: date)
        } else if timeSpan > 3600 {
            return Self.timeFormatterHHMM.string(from: date)
        } else {
            return Self.timeFormatterHHMMSS.string(from: date)
        }
    }
    
    /// 计算时间跨度
    private func calculateTimeSpan() -> TimeInterval {
        timeSpan
    }
    
    /// 获取最大时间戳
    private func getMaxTimestamp() -> Date {
        maxTimestamp
    }
    
    /// 获取最小时间戳
    private func getMinTimestamp() -> Date {
        minTimestamp
    }
    
    /// X轴建议刻度数量
    private var xAxisDesiredTickCount: Int {
        guard !dataPoints.isEmpty else { return 4 }
        let timeSpan = calculateTimeSpan()
        if timeSpan > 3600 * 12 {
            return 6
        } else if timeSpan > 3600 {
            return 5
        } else if timeSpan > 600 {
            return 4
        } else {
            return 3
        }
    }
    
    /// 获取Y轴范围域
    private func getYAxisDomain() -> ClosedRange<Double> {
        // 优先使用提供的范围管理器
        if let rangeManager = rangeManager {
            let (min, max) = rangeManager.getActualRange(for: dataPoints, type: .temperature)
            return min...max
        }
        
        // 其次使用提供的静态范围
        if let yAxisRange = yAxisRange {
            let (min, max) = yAxisRange.getActualRange(for: dataPoints)
            return min...max
        }
        
        // 默认自动计算范围
        guard let dataMin = minValue, let dataMax = maxValue else { return 0...100 }
        let range = dataMax - dataMin
        let padding = range * 0.1
        
        let min = max(0, dataMin - padding)
        let max = dataMax + padding
        
        return min...max
    }
    
    // MARK: - Colors
    
    private var gridColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.1)
            : Color.black.opacity(0.1)
    }
    
    private var labelColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.7)
            : Color.black.opacity(0.6)
    }
    
    private var plotBackgroundColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.02)
            : Color.black.opacity(0.01)
    }
    
    
    // MARK: - Display Mode
    
    /// 图表显示模式
    enum DisplayMode {
        /// 折线图
        case line
        /// 面积图
        case area
        /// 散点图
        case point
    }
}

// MARK: - Preview

#if DEBUG
struct TemperatureLineChart_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 折线图
                BlurGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("温度趋势 - 折线图")
                            .font(.headline)
                        
                        TemperatureLineChart(
                            dataPoints: ChartDataPoint.temperatureExamples(count: 60, label: "CPU")
                                + ChartDataPoint.temperatureExamples(count: 60, label: "GPU"),
                            displayMode: .line,
                            height: 250
                        )
                    }
                }
                .padding()
                
                // 面积图
                BlurGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("温度趋势 - 面积图")
                            .font(.headline)
                        
                        TemperatureLineChart(
                            dataPoints: ChartDataPoint.temperatureExamples(count: 60, label: "CPU"),
                            displayMode: .area,
                            height: 250
                        )
                    }
                }
                .padding()
                
                // 空状态
                BlurGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("空状态")
                            .font(.headline)
                        
                        TemperatureLineChart(
                            dataPoints: [],
                            height: 200
                        )
                    }
                }
                .padding()
            }
        }
        .auraBackground()
    }
}
#endif
