import UIKit

///
/// 記事
///
struct Article {
    let title: String
    let url: URL
    let host: String
    let pubDate: Date
    let pubDateString: String
    let thumbsUrl: URL?
    var thumbsImage: UIImage?
    var isRead: Bool = false
}
