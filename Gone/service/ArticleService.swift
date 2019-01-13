import Foundation
import UIKit

protocol ArticleService {
    func parse(data: Data, keyword: String) -> [Article]?

    func parseDateString(dateString: String) -> Date?

    func parseDate(date: Date) -> String

    func requireReloading()

    func isNecessaryReloading() -> Bool

    func doneReloading()

    func markAsRead(keyword: String, url: URL)

    func checkMarkingAsRead(keyword: String, articles: [Article]) -> [Article]

    func removeMarkingAsRead(for keywords: [String])
}

extension ArticleService {
    ///
    /// 日付を表示する日付文字列に変換
    ///
    func parseDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        return formatter.string(from: date)
    }

    ///
    /// 更新が必要であることを通知する
    ///
    func requireReloading() {
        UserDefaults.standard.set(true, forKey: "requireReloading")
    }

    ///
    /// 更新が必要であるか
    ///
    func isNecessaryReloading() -> Bool {
        return UserDefaults.standard.bool(forKey: "requireReloading")
    }

    ///
    /// 更新が完了したことを通知する
    ///
    func doneReloading() {
        UserDefaults.standard.set(false, forKey: "requireReloading")
    }

    ///
    /// 記事を既読にする
    ///
    func markAsRead(keyword: String, url: URL) {
        let urlString = url.absoluteString
        var asRead = UserDefaults.standard.array(forKey: "markAsRead" + keyword) as? [String] ?? [String]()
        asRead = Array(asRead.suffix(100))

        asRead.append(urlString)
        UserDefaults.standard.set(asRead, forKey: "markAsRead" + keyword)
    }

    ///
    /// 記事が既読であるかをチェックする
    ///
    func checkMarkingAsRead(keyword: String, articles: [Article]) -> [Article] {
        let asRead = UserDefaults.standard.array(forKey: "markAsRead" + keyword) as? [String] ?? [String]()
        var newAsRead = [String]()
        var newArticles = [Article]()

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

    ///
    /// キーワードごとの既読情報を削除する
    ///
    func removeMarkingAsRead(for keywords: [String]) {
        keywords.forEach { (keyword) in
            UserDefaults.standard.removeObject(forKey: keyword)
        }
    }
}
