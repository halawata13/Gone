import Foundation
import UIKit
import SlideMenuControllerSwift

class GnewsListViewController: ArticleListViewController, ArticleList {
    let articleService = GnewsService()
    var dataSource = ArticleListTableViewDataSource(articles: [Article]())

    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var messageView: MessageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articleListTableView.delegate = self

        setup()
        initArticle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        slideMenuController()?.delegate = self
    }
}

extension GnewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openArticle(urlString: dataSource.articles[indexPath.row].url)
    }
}

extension GnewsListViewController: SlideMenuControllerDelegate {
    public func leftWillClose() {
        requestArticleBySelectedKeyword()
        articleListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}
