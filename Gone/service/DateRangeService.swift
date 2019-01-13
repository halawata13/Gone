import Foundation

class DateRangeService {
    private static let udDateRange = "udDateRange"

    static let defaultItem = DateRange.h24

    static let items = [
        DateRange.h24,
        DateRange.d3,
        DateRange.w1,
        DateRange.m1,
        DateRange.m3,
        DateRange.m6,
        DateRange.y1,
        DateRange.unlimited
    ]

    enum DateRange: String {
        case h24 = "24時間"
        case d3 = "3日"
        case w1 = "1週間"
        case m1 = "1ヶ月"
        case m3 = "3ヶ月"
        case m6 = "6ヶ月"
        case y1 = "1年"
        case unlimited = "無制限"
    }

    ///
    /// 記事の取得期間を保存する
    ///
    static func setDateRange(_ dateRange: DateRange) {
        UserDefaults.standard.set(dateRange.rawValue, forKey: DateRangeService.udDateRange)
    }

    ///
    /// 記事の取得期間を取得する
    ///
    static func getDateRange() -> DateRange {
        guard let value = UserDefaults.standard.string(forKey: DateRangeService.udDateRange) else {
            return DateRangeService.defaultItem
        }

        return DateRange(rawValue: value) ?? DateRangeService.defaultItem
    }

    ///
    /// 記事の取得期間に基づいて記事をフィルタする
    ///
    static func filter(articles: [Article]) -> [Article] {
        let dateRange = DateRangeService.getDateRange()

        if dateRange == .unlimited {
            return articles
        }

        return articles.filter {
            return $0.pubDate > Date(timeIntervalSinceNow: -DateRangeService.getTimeInterval(dateRange: dateRange))
        }
    }

    ///
    /// 記事の取得期間の秒を返す
    ///
    private static func getTimeInterval(dateRange: DateRange) -> TimeInterval {
        switch dateRange {
        case .h24:
            return 60 * 60 * 24
        case .d3:
            return 60 * 60 * 24 * 3
        case .w1:
            return 60 * 60 * 24 * 7
        case .m1:
            return 60 * 60 * 24 * 30
        case .m3:
            return 60 * 60 * 24 * 90
        case .m6:
            return 60 * 60 * 24 * 180
        case .y1:
            return 60 * 60 * 24 * 365
        case .unlimited:
            return 0
        }
    }
}
