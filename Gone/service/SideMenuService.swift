import Foundation

class SideMenuService {
    private static let udKeywordsKey = "udKeywords"
    private static let udSelectedKeywordKey = "udSelectedKeywordKey"

    static let fixedKeywords = [
        "新着エントリー"
    ]

    static let defaultKeywords = [
        "Swift",
        "Kotlin",
    ]

    static func setKeywords(_ keywords: [String]) {
        UserDefaults.standard.set(keywords, forKey: SideMenuService.udKeywordsKey)
    }

    static func getEditableKeywords() -> [String] {
        return UserDefaults.standard.array(forKey: SideMenuService.udKeywordsKey) as? [String] ?? defaultKeywords
    }

    static func getAllKeywords() -> [String] {
        return SideMenuService.fixedKeywords + SideMenuService.getEditableKeywords()
    }

    static func setSelectedKeyword(_ keyword: String) {
        UserDefaults.standard.set(keyword, forKey: SideMenuService.udSelectedKeywordKey)
    }

    static func getSelectedKeyword() -> String? {
        return UserDefaults.standard.string(forKey: SideMenuService.udSelectedKeywordKey)
    }
}
