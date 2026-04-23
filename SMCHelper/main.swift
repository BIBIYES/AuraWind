//
//  main.swift
//  SMCHelper
//
//  Created by 凌峰 on 2025/11/17.
//

import Foundation

/// Helper Tool 主入口
/// 这个程序以 root 权限运行，负责实际的 SMC 访问
class SMCHelperTool: NSObject, NSXPCListenerDelegate, HelperToolProtocol {
    
    // MARK: - Properties
    
    /// XPC 监听器
    private var listener: NSXPCListener?
    
    /// SMC 连接实例
    private var smcConnection: SMCConnection?
    
    /// 是否已连接到 SMC
    private var isConnected = false

    /// 传感器列表缓存，减少重复全量扫描
    private var cachedAvailableSensors: [String] = []
    private var sensorCacheTimestamp: Date = .distantPast
    private let sensorCacheTTL: TimeInterval = 15.0

    /// 调试日志开关（默认关闭，避免高频日志拖慢系统）
    private let verboseLoggingEnabled = ProcessInfo.processInfo.environment["AURAWIND_HELPER_VERBOSE"] == "1"
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        setupLogging()
    }
    
    /// 启动 Helper Tool
    func run() {
        log("SMC Helper Tool 启动中...")
        log("版本: \(HelperToolConstants.helperToolVersion)")
        log("Bundle ID: \(HelperToolConstants.helperToolBundleID)")
        
        // 创建 XPC 监听器
        listener = NSXPCListener(machServiceName: HelperToolConstants.helperToolMachServiceName)
        listener?.delegate = self
        listener?.resume()
        
        log("XPC 监听器已启动，等待连接...")
        
        // 保持运行
        RunLoop.main.run()
    }
    
    // MARK: - NSXPCListenerDelegate
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        log("收到新的 XPC 连接请求")
        
        // 配置连接
        newConnection.exportedInterface = NSXPCInterface(with: HelperToolProtocol.self)
        newConnection.exportedObject = self
        
        // 设置中断和失效处理
        newConnection.interruptionHandler = { [weak self] in
            self?.log("XPC 连接中断")
        }
        
        newConnection.invalidationHandler = { [weak self] in
            self?.log("XPC 连接失效")
        }
        
        // 激活连接
        newConnection.resume()
        
        log("XPC 连接已建立")
        return true
    }
    
    // MARK: - HelperToolProtocol - SMC 连接管理
    
    func connectToSMC(reply: @escaping (Bool, String?) -> Void) {
        log("尝试连接到 SMC...")
        
        guard !isConnected else {
            log("SMC 已连接")
            reply(true, nil)
            return
        }
        
        do {
            let connection = SMCConnection()
            try connection.connect()
            
            smcConnection = connection
            isConnected = true
            cachedAvailableSensors = []
            sensorCacheTimestamp = .distantPast
            
            log("✅ SMC 连接成功")
            reply(true, nil)
            
        } catch {
            log("❌ SMC 连接失败: \(error.localizedDescription)")
            reply(false, error.localizedDescription)
        }
    }
    
    func disconnectFromSMC(reply: @escaping () -> Void) {
        log("断开 SMC 连接...")
        
        smcConnection?.disconnect()
        smcConnection = nil
        isConnected = false
        cachedAvailableSensors = []
        sensorCacheTimestamp = .distantPast
        
        log("SMC 已断开")
        reply()
    }
    
    // MARK: - HelperToolProtocol - SMC 读取操作
    
    func readSMCKey(_ key: String, reply: @escaping (Double, String?) -> Void) {
        log("读取 SMC 键: \(key)", level: .verbose)
        
        guard isConnected, let connection = smcConnection else {
            log("❌ SMC 未连接")
            reply(0, "SMC 未连接")
            return
        }
        
        do {
            // 根据键名推断数据类型
            let dataType = inferDataType(for: key)
            let result = try connection.readValue(key: key, type: dataType)
            
            log("✅ 读取成功: \(key) = \(result.value)", level: .verbose)
            reply(result.value, nil)
            
        } catch {
            log("❌ 读取失败: \(key) - \(error.localizedDescription)")
            reply(0, error.localizedDescription)
        }
    }
    
    func readTemperature(sensorKey: String, reply: @escaping (Double, String?) -> Void) {
        log("读取温度传感器: \(sensorKey)", level: .verbose)
        readSMCKey(sensorKey, reply: reply)
    }
    
    func getAllTemperatureSensors(reply: @escaping ([String], String?) -> Void) {
        guard isConnected, let connection = smcConnection else {
            reply([], "SMC 未连接")
            return
        }
        
        let now = Date()
        if !cachedAvailableSensors.isEmpty,
           now.timeIntervalSince(sensorCacheTimestamp) < sensorCacheTTL {
            log("温度传感器命中缓存: \(cachedAvailableSensors.count) 个", level: .verbose)
            reply(cachedAvailableSensors, nil)
            return
        }

        log("扫描可用温度传感器...")

        let sensorCandidates = preferredTemperatureSensors()
        var availableSensors: [String] = []
        var invalidValueCount = 0
        var readFailureCount = 0
        
        // 检查哪些传感器可用
        for sensor in sensorCandidates {
            do {
                let result = try connection.readValue(key: sensor, type: inferDataType(for: sensor))
                
                // 过滤明显无效的温度（Apple Silicon 上部分遗留键会稳定返回 0）
                if isPlausibleTemperature(result.value) {
                    availableSensors.append(sensor)
                } else {
                    invalidValueCount += 1
                    log("⚠️ 传感器跳过: \(sensor), 温度值疑似无效: \(result.value)°C", level: .verbose)
                }
            } catch {
                readFailureCount += 1
                log("❌ 传感器不可用: \(sensor), 错误: \(error.localizedDescription)", level: .verbose)
            }
        }

        cachedAvailableSensors = availableSensors
        sensorCacheTimestamp = Date()

        log("找到 \(availableSensors.count) 个可用传感器（无效值 \(invalidValueCount) 个，读取失败 \(readFailureCount) 个）")
        
        // 如果没有找到传感器，记录详细错误
        if availableSensors.isEmpty {
            log("⚠️ 警告：没有找到任何可用的温度传感器！")
            log("⚠️ SMC 连接状态: \(isConnected)")
            log("⚠️ 这可能是因为 SMC 键不存在或读取失败")
        }
        
        reply(availableSensors, nil)
    }
    
    // MARK: - HelperToolProtocol - 风扇控制
    
    func getFanCount(reply: @escaping (Int, String?) -> Void) {
        log("获取风扇数量...")
        
        guard isConnected, let connection = smcConnection else {
            reply(0, "SMC 未连接")
            return
        }
        
        do {
            let result = try connection.readValue(key: "FNum", type: .ui8)
            let count = Int(result.value)
            
            log("✅ 风扇数量: \(count)")
            reply(count, nil)
            
        } catch {
            log("❌ 获取风扇数量失败: \(error.localizedDescription)")
            reply(0, error.localizedDescription)
        }
    }
    
    func getFanInfo(index: Int, reply: @escaping (NSDictionary?, String?) -> Void) {
        log("获取风扇 \(index) 信息...", level: .verbose)
        
        guard isConnected, let connection = smcConnection else {
            reply(nil, "SMC 未连接")
            return
        }
        
        do {
            // 读取风扇信息
            let minSpeed = try connection.readValue(key: "F\(index)Mn", type: .fpe2)
            let maxSpeed = try connection.readValue(key: "F\(index)Mx", type: .fpe2)
            let currentSpeed = try connection.readValue(key: "F\(index)Ac", type: .fpe2)
            
            let info: NSDictionary = [
                "index": index,
                "minSpeed": Int(minSpeed.value),
                "maxSpeed": Int(maxSpeed.value),
                "currentSpeed": Int(currentSpeed.value),
                "name": "Fan \(index)"
            ]
            
            log("✅ 风扇信息: \(info)", level: .verbose)
            reply(info, nil)
            
        } catch {
            log("❌ 获取风扇信息失败: \(error.localizedDescription)")
            reply(nil, error.localizedDescription)
        }
    }
    
    func setFanSpeed(index: Int, rpm: Int, reply: @escaping (Bool, String?) -> Void) {
        log("设置风扇 \(index) 转速为 \(rpm) RPM...")
        
        guard isConnected, let connection = smcConnection else {
            reply(false, "SMC 未连接")
            return
        }
        
        do {
            // 先设置为手动模式
            try connection.writeValue(key: "F\(index)Md", value: 1, type: .ui8)
            
            // 设置目标转速
            try connection.writeValue(key: "F\(index)Tg", value: Double(rpm), type: .fpe2)
            
            log("✅ 风扇转速设置成功")
            reply(true, nil)
            
        } catch {
            log("❌ 设置风扇转速失败: \(error.localizedDescription)")
            reply(false, error.localizedDescription)
        }
    }
    
    func setFanAutoMode(index: Int, reply: @escaping (Bool, String?) -> Void) {
        log("设置风扇 \(index) 为自动模式...")
        
        guard isConnected, let connection = smcConnection else {
            reply(false, "SMC 未连接")
            return
        }
        
        do {
            // 设置为自动模式
            try connection.writeValue(key: "F\(index)Md", value: 0, type: .ui8)
            
            log("✅ 风扇自动模式设置成功")
            reply(true, nil)
            
        } catch {
            log("❌ 设置风扇自动模式失败: \(error.localizedDescription)")
            reply(false, error.localizedDescription)
        }
    }
    
    // MARK: - HelperToolProtocol - 系统信息
    
    func getVersion(reply: @escaping (String) -> Void) {
        reply(HelperToolConstants.helperToolVersion)
    }
    
    func checkStatus(reply: @escaping (NSDictionary) -> Void) {
        let status: NSDictionary = [
            "version": HelperToolConstants.helperToolVersion,
            "isConnected": isConnected,
            "bundleID": HelperToolConstants.helperToolBundleID,
            "timestamp": Date().timeIntervalSince1970
        ]
        reply(status)
    }
    
    // MARK: - Private Methods
    
    /// 根据键名推断数据类型
    private func inferDataType(for key: String) -> SMCConnection.SMCDataType {
        // 温度传感器通常使用 sp78 格式
        if key.starts(with: "T") {
            return .sp78
        }
        
        // 风扇相关
        if key.starts(with: "F") {
            if key.hasSuffix("Mn") || key.hasSuffix("Mx") || key.hasSuffix("Ac") || key.hasSuffix("Tg") {
                return .fpe2
            }
            if key.hasSuffix("Md") || key == "FNum" {
                return .ui8
            }
        }
        
        // 默认使用 flt
        return .flt
    }
    
    /// 根据硬件型号返回更可能可用的温度键（Apple Silicon 优先）
    private func preferredTemperatureSensors() -> [String] {
        let fallbackKeys = [
            "TC0P", "TC0D", "TC0E", "TC0F",
            "TG0P", "TG0D",
            "Th0H", "Tm0P", "TN0P", "TA0P", "TB0T"
        ]
        
        let model = currentHardwareModel()
        
        if model.hasPrefix("MacBookPro18") || model.hasPrefix("MacBookAir10") || model.hasPrefix("Mac12") {
            return [
                "Tp09", "Tp0T", "Tp01", "Tp05", "Tp0D", "Tp0H", "Tp0L", "Tp0P", "Tp0X", "Tp0b",
                "Tg05", "Tg0D", "Tg0L", "Tg0T",
                "Tm02", "Tm06", "Tm08", "Tm09"
            ] + fallbackKeys
        }
        
        return fallbackKeys
    }
    
    private func currentHardwareModel() -> String {
        var size: Int = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        guard size > 0 else { return "" }
        
        var model = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.model", &model, &size, nil, 0)
        
        return String(cString: model)
    }

    /// 温度值合理性检查（用于过滤无效键）
    private func isPlausibleTemperature(_ value: Double) -> Bool {
        value >= 1.0 && value <= 130.0
    }
    
    /// 设置日志
    private func setupLogging() {
        // 日志输出到系统日志
        // 可以使用 Console.app 查看
    }
    
    /// 日志级别
    private enum LogLevel {
        case normal
        case verbose
    }

    /// 记录日志
    private func log(_ message: String, level: LogLevel = .normal) {
        guard level == .normal || verboseLoggingEnabled else { return }

        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        let logMessage = "[\(timestamp)] SMCHelper: \(message)"
        
        // 仅写 stdout，避免 stdout/stderr 双写导致日志成倍增长。
        print(logMessage)
    }
}

// MARK: - 程序入口

autoreleasepool {
    let helper = SMCHelperTool()
    helper.run()
}
