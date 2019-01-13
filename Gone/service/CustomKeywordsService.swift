import Foundation
import UIKit

class CustomKeywordsService {
    static let sectionTitle = "キーワード"

    private static let udKeywordsKey = "udKeywords"
    private static let udSelectedKeywordKey = "udSelectedKeywordKey"

    ///
    /// キーワードをすべて取得する
    ///
    static func getAll() -> [String] {
        return UserDefaults.standard.array(forKey: CustomKeywordsService.udKeywordsKey) as? [String] ?? [String]()
    }

    ///
    /// キーワードを追加する
    ///
    static func set(_ keywords: [String]) {
        UserDefaults.standard.set(keywords, forKey: CustomKeywordsService.udKeywordsKey)
    }

    ///
    /// キーワードからURL文字列を取得する
    ///
    static func getUrlString(for keyword: String) -> String? {
        guard let keyword = keyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return nil
        }

        return "https://news.google.com/rss/search?amp;hl=ja&q=" + keyword + "&hl=ja&gl=JP&ceid=JP:ja"
    }

    ///
    /// キーワードから固有の色を取得する
    ///
    static func getColor(for keyword: String) -> UIColor {
        guard let cString = keyword.cString(using: String.Encoding.utf8) else {
            return UIColor.darkGray
        }

        // キーワード名からハッシュ値を取って色相として使う
        var result: [CUnsignedChar] = Array(repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1(cString, CC_LONG(cString.count - 1), &result)

        let sha1 = (0..<Int(CC_SHA1_DIGEST_LENGTH)).reduce("") { $0 + String(format: "%02hhx", result[$1]) }
        let hue = Int(String(sha1).prefix(2), radix: 16) ?? 0

        return UIColor(hue: CGFloat(hue) / 255, saturation: 0.5, brightness: 0.97, alpha: 1)
    }
}
