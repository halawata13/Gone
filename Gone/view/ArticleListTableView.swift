import Foundation
import UIKit

class ArticleListTableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()

        separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        register(UINib(nibName: ArticleListTableViewCell.className, bundle: nil), forCellReuseIdentifier: ArticleListTableViewCell.className)
    }
}
