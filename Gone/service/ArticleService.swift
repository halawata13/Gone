import Foundation
import UIKit

protocol ArticleService {
    func parse(data: Data) -> [Article]?

    func getDefaultTitle() -> String

    func getDefaultUrlString() -> String

    func getUrlString(keyword: String) -> String?

    func getThemeColor() -> UIColor

    func getTintColor() -> UIColor

    func parseDateString(dateString: String) -> Date?

    func parseDate(date: Date) -> String

    func requireReloading()

    func isNecessaryReloading() -> Bool

    func markAsRead(keyword: String, url: URL)

    func checkMarkingAsRead<T: Article>(keyword: String, articles: [T]) -> [T]

    func removeMarkingAsRead(for keywords: [String])
}

extension ArticleService {
    func requireReloading() {
        UserDefaults.standard.set(true, forKey: "requireReloading")
    }

    func isNecessaryReloading() -> Bool {
        return UserDefaults.standard.bool(forKey: "requireReloading")
    }

    func markAsRead(keyword: String, url: URL) {
        let urlString = url.absoluteString
        var asRead = UserDefaults.standard.array(forKey: "markAsRead" + keyword) as? [String] ?? [String]()

        asRead.append(urlString)
        UserDefaults.standard.set(asRead, forKey: "markAsRead" + keyword)
    }

    func checkMarkingAsRead<T: Article>(keyword: String, articles: [T]) -> [T] {
        let asRead = UserDefaults.standard.array(forKey: "markAsRead" + keyword) as? [String] ?? [String]()
        var newAsRead = [String]()
        var newArticles = [T]()

        for var article in articles {
            if asRead.contains(article.url.absoluteString) {
                article.isRead = true
                newAsRead.append(article.url.absoluteString)
            }

            newArticles.append(article)
        }

        UserDefaults.standard.set(newAsRead, forKey: "markAsRead" + keyword)

        return newArticles
    }

    func removeMarkingAsRead(for keywords: [String]) {
        keywords.forEach { (keyword) in
            UserDefaults.standard.removeObject(forKey: keyword)
        }
    }
}
