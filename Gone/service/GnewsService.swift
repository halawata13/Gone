import Foundation
import UIKit
import AEXML

class GnewsService: ArticleService {
    ///
    /// RSSをパースする
    ///
    func parse(data: Data, keyword: String) -> [Article]? {
        guard let xml = try? AEXMLDocument(xml: data) else {
            return nil
        }

        var articles = [Article]()

        // XMLパース
        if let items = xml.root["channel"]["item"].all {
            items.forEach { (item) in
                guard let url = URL(string: item["link"].string),
                      let host = url.host,
                      let pubDate = parseDateString(dateString: item["pubDate"].string) else {
                    return
                }

                let article = Article(
                    title: item["title"].string,
                    url: url,
                    host: host,
                    pubDate: pubDate,
                    pubDateString: parseDate(date: pubDate),
                    thumbsUrl: URL(string: item["media:content"].attributes["url"] ?? ""),
                    thumbsImage: nil,
                    isRead: false
                )

                articles.append(article)
            }
        }

        // 日付の取得期間を適用
        articles = DateRangeService.filter(articles: articles)

        // ミュートを適用
        articles = MuteService.filter(articles: articles)

        // 記事の日付順にソート
        articles.sort {
            return $0.pubDateString > $1.pubDateString
        }

        // 既読の記事をマーク
        articles = checkMarkingAsRead(keyword: keyword, articles: articles)

        return articles
    }

    ///
    /// XMLの日付文字列を日付に変換
    ///
    func parseDateString(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        return formatter.date(from: dateString)
    }
}
