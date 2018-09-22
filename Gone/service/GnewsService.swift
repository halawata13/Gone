import Foundation
import UIKit
import AEXML

class GnewsService: ArticleService {
    func parse(data: Data) -> [Article]? {
        guard let xml = try? AEXMLDocument(xml: data) else {
            return nil
        }

        var articles = [GnewsArticle]()

        if let items = xml.root["channel"]["item"].all {
            items.forEach { (item) in
                let article = GnewsArticle(
                    title: item["title"].string,
                    url: item["link"].string,
                    pubDate: parseDateString(dateString: item["pubDate"].string) ?? item["pubDate"].string
                )

                articles.append(article)
            }
        }

        articles.sort {
            return $0.pubDate > $1.pubDate
        }

        return articles
    }

    func getDefaultTitle() -> String {
        return ApiUrlService.Gnews.newEntryLabel
    }

    func getDefaultUrlString() -> String {
        return ApiUrlService.Gnews.newEntry
    }

    func getUrlString(keyword: String) -> String? {
        return ApiUrlService.Gnews.get(for: keyword)
    }

    func getThemeColor() -> UIColor {
        return UIColor(hue: 6 / 360, saturation: 0.81, brightness: 0.94, alpha: 1)
    }

    func parseDateString(dateString: String) -> String? {
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        guard let date = inFormatter.date(from: dateString) else {
            return nil
        }

        let outFormatter = DateFormatter()
        outFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        return outFormatter.string(from: date)
    }
}