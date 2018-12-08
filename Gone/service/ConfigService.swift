import Foundation

class ConfigService {
    static let items = [
        Item.menu,
        Item.mute,
    ]

    enum Item: String {
        case menu = "メニュー編集"
        case mute = "ミュート設定"
    }
}
