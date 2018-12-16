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
                guard let url = URL(string: item["link"].string),
                      let host = url.host,
                      let pubDate = parseDateString(dateString: item["pubDate"].string) else {
                    return
                }

                let article = GnewsArticle(
                    title: item["title"].string,
                    url: url,
                    host: host,
                    pubDate: pubDate,
                    pubDateString: parseDate(date: pubDate),
                    isRead: false
                )

                articles.append(article)
            }
        }

        articles = DateRangeService.filter(articles: articles)

        articles = MuteService.filter(articles: articles)

        articles.sort {
            return $0.pubDateString > $1.pubDateString
        }

        let keyword = SideMenuService.getSelectedKeyword() ?? SideMenuService.fixedKeywords[0]
        articles = checkMarkingAsRead(keyword: keyword, articles: articles)

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
        return UIColor(hue: 220 / 360, saturation: 0.36, brightness: 0.37, alpha: 1)
    }

    func getTintColor() -> UIColor {
        return UIColor.white
    }

    func parseDateString(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        return formatter.date(from: dateString)
    }

    func parseDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        return formatter.string(from: date)
    }
}
