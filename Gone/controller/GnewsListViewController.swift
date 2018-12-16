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

        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onLongPressedTableViewCell)))

        setup()
        initArticle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        slideMenuController()?.delegate = self

        if articleService.isNecessaryReloading() {
            requestArticleBySelectedKeyword()
        }
    }

    @objc func onLongPressedTableViewCell(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began,
              let indexPath = articleListTableView.indexPathForRow(at: recognizer.location(in: articleListTableView)) else {
            return
        }

        let article = dataSource.articles[indexPath.row]
        let alertController = UIAlertController(title: article.host, message: nil, preferredStyle: .alert)

        let muteAction = UIAlertAction(title: "このサイトの記事をミュートする", style: .default) { [weak self] (action) in
            MuteService.setMute(host: article.host)
            self?.requestArticleBySelectedKeyword()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)

        alertController.addAction(muteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

extension GnewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ArticleListTableViewCell
        cell?.setRead(isRead: true)

        let keyword = SideMenuService.getSelectedKeyword() ?? SideMenuService.fixedKeywords[0]
        articleService.markAsRead(keyword: keyword, url: dataSource.articles[indexPath.row].url)

        openArticle(url: dataSource.articles[indexPath.row].url)
    }
}

extension GnewsListViewController: SlideMenuControllerDelegate {
    public func leftWillClose() {
        requestArticleBySelectedKeyword()

        if dataSource.articles.count > 0 {
            articleListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}
