import CodexBarCore
import Foundation

enum MenuBarDisplayText {
    static func percentText(window: RateWindow?, showUsed: Bool) -> String? {
        guard let window else { return nil }
        let percent = showUsed ? window.usedPercent : window.remainingPercent
        let clamped = min(100, max(0, percent))
        return String(format: "%.0f%%", clamped)
    }

    static func paceText(pace: UsagePace?) -> String? {
        guard let pace else { return nil }
        let deltaValue = Int(abs(pace.deltaPercent).rounded())
        let sign = pace.deltaPercent >= 0 ? "+" : "-"
        return "\(sign)\(deltaValue)%"
    }

    static func compactTimeText(from date: Date, now: Date = .init()) -> String? {
        let seconds = max(0, date.timeIntervalSince(now))
        if seconds < 1 { return "now" }

        let totalMinutes = max(1, Int(ceil(seconds / 60.0)))
        let days = totalMinutes / (24 * 60)
        let hours = (totalMinutes / 60) % 24
        let minutes = totalMinutes % 60

        if days > 0 {
            if hours > 0 { return "\(days)d\(hours)h" }
            return "\(days)d"
        }
        if hours > 0 {
            if minutes > 0 { return "\(hours)h\(minutes)m" }
            return "\(hours)h"
        }
        return "\(totalMinutes)m"
    }

    static func spacedTimeText(from date: Date, now: Date = .init()) -> String? {
        let seconds = max(0, date.timeIntervalSince(now))
        if seconds < 1 { return "now" }

        let totalMinutes = max(1, Int(ceil(seconds / 60.0)))
        let days = totalMinutes / (24 * 60)
        let hours = (totalMinutes / 60) % 24
        let minutes = totalMinutes % 60

        if days > 0 {
            if hours > 0 { return "\(days)d \(hours)h" }
            return "\(days)d"
        }
        if hours > 0 {
            if minutes > 0 { return "\(hours)h \(minutes)m" }
            return "\(hours)h"
        }
        return "\(totalMinutes)m"
    }

    static func sessionDetailText(primary: RateWindow?, secondary: RateWindow?, showUsed: Bool) -> String? {
        guard let primary else { return nil }
        let primaryPercent = showUsed ? primary.usedPercent : primary.remainingPercent
        let primaryClamped = min(100, max(0, primaryPercent))
        let primaryTime = primary.resetsAt.flatMap { spacedTimeText(from: $0) } ?? "?"

        var parts = [String(format: "S:%.0f%% (\(primaryTime))", primaryClamped)]

        if let secondary = secondary {
            let secondaryPercent = showUsed ? secondary.usedPercent : secondary.remainingPercent
            let secondaryClamped = min(100, max(0, secondaryPercent))
            let secondaryTime = secondary.resetsAt.flatMap { spacedTimeText(from: $0) } ?? "?"
            parts.append(String(format: "W:%.0f%% (\(secondaryTime))", secondaryClamped))
        }

        return parts.joined(separator: " ")
    }

    static func compactText(primary: RateWindow?, secondary: RateWindow?, showUsed: Bool) -> String? {
        guard let primary else { return nil }
        let primaryPercent = showUsed ? primary.usedPercent : primary.remainingPercent
        let primaryClamped = min(100, max(0, primaryPercent))
        let primaryTime = primary.resetsAt.flatMap { compactTimeText(from: $0) } ?? "?"

        var parts = [String(format: "%.0f%% \(primaryTime)", primaryClamped)]

        if let secondary = secondary {
            let secondaryPercent = showUsed ? secondary.usedPercent : secondary.remainingPercent
            let secondaryClamped = min(100, max(0, secondaryPercent))
            let secondaryTime = secondary.resetsAt.flatMap { compactTimeText(from: $0) } ?? "?"
            parts.append(String(format: "%.0f%% \(secondaryTime)", secondaryClamped))
        }

        return parts.joined(separator: " | ")
    }

    static func compactWithLabelText(primary: RateWindow?, secondary: RateWindow?, showUsed: Bool) -> String? {
        guard let primary else { return nil }
        let primaryPercent = showUsed ? primary.usedPercent : primary.remainingPercent
        let primaryClamped = min(100, max(0, primaryPercent))
        let primaryTime = primary.resetsAt.flatMap { compactTimeText(from: $0) } ?? "?"

        var parts = [String(format: "S %.0f%% \(primaryTime)", primaryClamped)]

        if let secondary = secondary {
            let secondaryPercent = showUsed ? secondary.usedPercent : secondary.remainingPercent
            let secondaryClamped = min(100, max(0, secondaryPercent))
            let secondaryTime = secondary.resetsAt.flatMap { compactTimeText(from: $0) } ?? "?"
            parts.append(String(format: "W %.0f%% \(secondaryTime)", secondaryClamped))
        }

        return parts.joined(separator: " ")
    }

    static func sessionTimeFormat(from date: Date, now: Date = .init()) -> String {
        let seconds = max(0, date.timeIntervalSince(now))
        if seconds < 1 { return "00:00" }

        let totalMinutes = max(1, Int(ceil(seconds / 60.0)))
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        return String(format: "%02d:%02d", hours, minutes)
    }

    static func weeklyTimeFormat(from date: Date, now: Date = .init()) -> String {
        let seconds = max(0, date.timeIntervalSince(now))
        if seconds < 1 { return "0:00" }

        let totalMinutes = max(1, Int(ceil(seconds / 60.0)))
        let days = totalMinutes / (24 * 60)
        let hours = (totalMinutes / 60) % 24

        return String(format: "%d:%02d", days, hours)
    }

    static func minimalText(primary: RateWindow?, secondary: RateWindow?, showUsed: Bool) -> String? {
        guard let primary else { return nil }
        let primaryPercent = showUsed ? primary.usedPercent : primary.remainingPercent
        let primaryClamped = Int(min(100, max(0, primaryPercent)))
        let primaryTime = primary.resetsAt.map { sessionTimeFormat(from: $0) } ?? "??:??"

        var parts = ["\(primaryClamped) \(primaryTime)"]

        if let secondary = secondary {
            let secondaryPercent = showUsed ? secondary.usedPercent : secondary.remainingPercent
            let secondaryClamped = Int(min(100, max(0, secondaryPercent)))
            let secondaryTime = secondary.resetsAt.map { weeklyTimeFormat(from: $0) } ?? "?:??"
            parts.append("\(secondaryClamped) \(secondaryTime)")
        }

        return parts.joined(separator: " / ")
    }

    static func displayText(
        mode: MenuBarDisplayMode,
        percentWindow: RateWindow?,
        pace: UsagePace? = nil,
        showUsed: Bool,
        primary: RateWindow? = nil,
        secondary: RateWindow? = nil) -> String?
    {
        switch mode {
        case .percent:
            return self.percentText(window: percentWindow, showUsed: showUsed)
        case .pace:
            return self.paceText(pace: pace)
        case .both:
            guard let percent = percentText(window: percentWindow, showUsed: showUsed) else { return nil }
            let paceText: String? = Self.paceText(pace: pace)
            guard let paceText else { return nil }
            return "\(percent) · \(paceText)"
        case .sessionDetail:
            return sessionDetailText(primary: primary ?? percentWindow, secondary: secondary, showUsed: showUsed)
        case .compact:
            return compactText(primary: primary ?? percentWindow, secondary: secondary, showUsed: showUsed)
        case .compactWithLabel:
            return compactWithLabelText(primary: primary ?? percentWindow, secondary: secondary, showUsed: showUsed)
        case .minimal:
            return minimalText(primary: primary ?? percentWindow, secondary: secondary, showUsed: showUsed)
        }
    }
}
