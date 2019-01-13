import Foundation
import UIKit

class SideMenuService {
    private static let udKeywordsKey = "udKeywords"
    private static let udSelectedKeywordKey = "udSelectedKeywordKey"

    ///
    /// カスタムキーワードを保存する
    ///
    static func setCustomKeywords(_ keywords: [String]) {
        UserDefaults.standard.set(keywords, forKey: SideMenuService.udKeywordsKey)
    }

    ///
    /// カスタムキーワードを取得する
    ///
    static func getCustomKeywords() -> [String] {
        return UserDefaults.standard.array(forKey: SideMenuService.udKeywordsKey) as? [String] ?? [String]()
    }

    ///
    /// サイドメニューを取得する
    ///
    static func getSideMenu() -> SideMenu {
        let customKeywords = CustomKeywordsService.getAll()
        let topics = TopicsService.getAll()
        var sections = [String]()
        var items = [[String]]()

        if customKeywords.count > 0 {
            sections.append(CustomKeywordsService.sectionTitle)
            items.append(customKeywords)
        }

        if topics.count > 0 {
            sections.append(TopicsService.sectionTitle)
            items.append(topics)
        }

        return SideMenu(sections: sections, items: items)
    }

    ///
    /// カスタムキーワードとトピックスを取得する
    ///
    static func getAllKeywords() -> [String] {
        return CustomKeywordsService.getAll() + TopicsService.getAll()
    }

    ///
    /// 選択したキーワードを保存する
    ///
    static func setSelectedKeyword(_ keyword: String) {
        UserDefaults.standard.set(keyword, forKey: SideMenuService.udSelectedKeywordKey)
    }

    ///
    /// 選択したキーワードを取得する
    ///
    static func getSelectedKeyword() -> String? {
        return UserDefaults.standard.string(forKey: SideMenuService.udSelectedKeywordKey)
    }

    ///
    /// デフォルトのキーワードを取得する
    ///
    static func getDefaultKeyword() -> String? {
        return SideMenuService.getAllKeywords().first
    }

    ///
    /// キーワードからRSSのURLを取得する
    ///
    static func getUrlString(for keyword: String) -> String? {
        return TopicsService.getUrlString(for: keyword) ?? CustomKeywordsService.getUrlString(for: keyword)
    }

    ///
    /// キーワードから固有の色を取得する
    ///
    static func getColor(for keyword: String) -> UIColor {
        return TopicsService.getColor(for: keyword) ?? CustomKeywordsService.getColor(for: keyword)
    }

    struct SideMenu {
        let sections: [String]
        let items: [[String]]
    }
}
