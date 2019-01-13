import UIKit

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var thumbsImageView: UIImageView!

    ///
    /// 記事の情報をセットする
    ///
    func setArticle(_ article: Article) {
        titleLabel.text = article.title
        pubDateLabel.text = article.pubDateString
        urlLabel.text = article.host
        setThumbsImage(article.thumbsImage)
        thumbsImageView.isHidden = article.thumbsUrl == nil

        setRead(isRead: article.isRead)
    }

    ///
    /// 記事のサムネイルをセットする
    ///
    func setThumbsImage(_ thumbsImage: UIImage?) {
        thumbsImageView.image = thumbsImage
    }

    ///
    /// 既読表示にする
    ///
    func setRead(isRead: Bool) {
        titleLabel.textColor = isRead ? UIColor.gray : UIColor.black
    }
}
