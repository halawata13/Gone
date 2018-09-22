import Foundation
import UIKit

protocol ArticleService {
    func parse(data: Data) -> [Article]?

    func getDefaultTitle() -> String

    func getDefaultUrlString() -> String

    func getUrlString(keyword: String) -> String?

    func getThemeColor() -> UIColor

    func parseDateString(dateString: String) -> String?
}
