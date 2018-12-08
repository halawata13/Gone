import Foundation

protocol Article {
    var title: String { get }
    var url: URL { get }
    var host: String { get }
    var pubDate: String { get }
    var isRead: Bool { get set }
}
