import Foundation

class ConfigService {
    static let items = [
        Item.menu,
        Item.mute,
        Item.dateRange,
    ]

    enum Item: String {
        case menu = "メニュー編集"
        case mute = "ミュート設定"
        case dateRange = "記事の取得期間"
    }
}
