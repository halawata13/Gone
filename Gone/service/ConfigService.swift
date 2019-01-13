import Foundation

class ConfigService {
    static let items = [
        Item.menu,
        Item.mute,
        Item.dateRange,
    ]

    enum Item: String {
        case menu = "キーワード"
        case mute = "ミュート"
        case dateRange = "記事の取得期間"
    }
}
