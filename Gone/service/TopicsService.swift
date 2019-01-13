import Foundation
import UIKit

class TopicsService {
    static let sectionTitle = "トピックス"

    private static let keywords = [
        Keyword.nation.rawValue,
        Keyword.world.rawValue,
        Keyword.business.rawValue,
        Keyword.politics.rawValue,
        Keyword.entertainment.rawValue,
        Keyword.sports.rawValue,
        Keyword.scitech.rawValue,
    ]

    private static let urls = [
        Keyword.nation: "https://news.google.com/rss/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNRE5mTTJRU0FtcGhLQUFQAQ?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.world: "https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx1YlY4U0FtcGhHZ0pLVUNnQVAB?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.business: "https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtcGhHZ0pLVUNnQVAB?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.politics: "https://news.google.com/rss/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNRFZ4ZERBU0FtcGhLQUFQAQ?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.entertainment: "https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREpxYW5RU0FtcGhHZ0pLVUNnQVAB?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.sports: "https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFp1ZEdvU0FtcGhHZ0pLVUNnQVAB?hl=ja&gl=JP&ceid=JP:ja",
        Keyword.scitech: "https://news.google.com/rss/topics/CAAqKAgKIiJDQkFTRXdvSkwyMHZNR1ptZHpWbUVnSnFZUm9DU2xBb0FBUAE?hl=ja&gl=JP&ceid=JP:ja",
    ]

    ///
    /// トピックスを取得する
    ///
    static func getAll() -> [String] {
        return TopicsService.keywords
    }

    ///
    /// トピックスからURLを取得する
    ///
    static func getUrlString(for keyword: String) -> String? {
        guard let keyword = Keyword(rawValue: keyword) else {
            return nil
        }

        return TopicsService.urls[keyword]
    }

    ///
    /// トピックスから固有の色を取得する
    ///
    static func getColor(for keyword: String) -> UIColor? {
        guard let keyword = Keyword(rawValue: keyword) else {
            return nil
        }

        var hue: CGFloat = 0

        switch keyword {
        case .nation:
            hue = 0
        case .world:
            hue = 50
        case .business:
            hue = 100
        case .politics:
            hue = 150
        case .entertainment:
            hue = 200
        case .sports:
            hue = 250
        case .scitech:
            hue = 300
        }

        return UIColor(hue: hue / 360, saturation: 0.5, brightness: 0.97, alpha: 1)
    }

    enum Keyword: String {
        case nation = "国内"
        case world = "国際"
        case business = "ビジネス"
        case politics = "政治"
        case entertainment = "エンタメ"
        case sports = "スポーツ"
        case scitech = "テクノロジー"
    }
}
