import Foundation

class ApiUrlService {
    class Gnews {
        static let newEntryLabel = "新着エントリー"
        static let newEntry = "https://news.google.com/news/rss/headlines/section/topic/SCITECH.ja_jp/%E3%83%86%E3%82%AF%E3%83%8E%E3%83%AD%E3%82%B8%E3%83%BC?ned=jp&hl=ja&gl=JP"

        static func get(for keyword: String) -> String? {
            if keyword == ApiUrlService.Gnews.newEntryLabel {
                return ApiUrlService.Gnews.newEntry
            }

            guard let keyword = keyword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                return nil
            }

            return "https://news.google.com/news/rss/headlines/section/q/" + keyword + "/" + keyword + "?ned=jp&amp;hl=ja&gl=JP"
        }
    }
}
