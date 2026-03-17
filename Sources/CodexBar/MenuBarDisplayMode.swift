import Foundation

/// Controls what the menu bar displays when brand icon mode is enabled.
enum MenuBarDisplayMode: String, CaseIterable, Identifiable {
    case percent
    case pace
    case both
    case sessionDetail
    case compact
    case compactWithLabel
    case minimal

    var id: String {
        self.rawValue
    }

    var label: String {
        switch self {
        case .percent: "Percent"
        case .pace: "Pace"
        case .both: "Both"
        case .sessionDetail: "Session Detail"
        case .compact: "Compact"
        case .compactWithLabel: "Compact with Label"
        case .minimal: "Minimal"
        }
    }

    var description: String {
        switch self {
        case .percent: "Show remaining/used percentage (e.g. 45%)"
        case .pace: "Show pace indicator (e.g. +5%)"
        case .both: "Show both percentage and pace (e.g. 45% · +5%)"
        case .sessionDetail: "Show session and weekly with time (e.g. S:94% (3h 36m) W:82% (2d 21h))"
        case .compact: "Show compact format (e.g. 94% 3h36m | 82% 2d21h)"
        case .compactWithLabel: "Show compact with labels (e.g. S 94% 3h36m W 82% 2d21h)"
        case .minimal: "Show minimal time format (e.g. 91 02:58 / 82 2:02)"
        }
    }
}
