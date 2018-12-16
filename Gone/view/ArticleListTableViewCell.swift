import UIKit

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    func setArticle(article: Article) {
        titleLabel.text = article.title
        pubDateLabel.text = article.pubDateString
        urlLabel.text = article.url.absoluteString

        setRead(isRead: article.isRead)
    }

    func setRead(isRead: Bool) {
        titleLabel.textColor = isRead ? UIColor.gray : UIColor.black
    }
}
