import Foundation
import UIKit

class ArticleListTableViewDataSource: NSObject, UITableViewDataSource {
    let articles: [Article]

    init(articles: [Article]) {
        self.articles = articles
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.className, for: indexPath) as! ArticleListTableViewCell
        cell.setArticle(article: articles[indexPath.row])

        return cell
    }
}
