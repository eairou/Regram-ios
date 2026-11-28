// MARK: Regram — global default only; an explicit per-video selection wins.
import Foundation

public enum RGVideoQualityPreference: String, CaseIterable {
    case automatic
    case highest
    case lowest
    case original

    public func selectedQuality(available: [Int]) -> Int? {
        let available = Set(available.filter { $0 > 0 })
        guard available.count > 1 else { return nil }
        switch self {
        //case .automatic: return nil
        case .automatic, .original:
            // 原画不是 HLS 的一个画质档位，不应映射到最高档。
            return nil
        case .highest: return available.max()
        case .lowest: return available.min()
        }
    }

    public static let settingsChanged = Notification.Name("Regram.DefaultVideoQualityChanged")
}
