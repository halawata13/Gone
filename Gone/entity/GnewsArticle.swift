import Foundation

///
/// Googleニュース記事
///
struct GnewsArticle: Article {
    let title: String
    let url: URL
    let host: String
    let pubDate: Date
    let pubDateString: String
    var isRead: Bool = false
}
