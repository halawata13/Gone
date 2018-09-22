import Foundation
import UIKit
import Alamofire
import SafariServices

protocol ArticleList: class {
    associatedtype ArticleServiceType: ArticleService

    var dataSource: ArticleListTableViewDataSource { get set }
    var articleListTableView: UITableView! { get set }
    var messageView: MessageView! { get set }
    var articleService: ArticleServiceType { get }
}

extension ArticleList where Self: UIViewController {
    func setup() {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor = articleService.getThemeColor()

        SideMenuService.setSelectedKeyword(articleService.getDefaultTitle())
    }

    func initArticle() {
        if let keyword = SideMenuService.getSelectedKeyword(),
           let urlString = articleService.getUrlString(keyword: keyword) {
            requestArticle(title: keyword, urlString: urlString)

        } else {
            requestArticle(title: articleService.getDefaultTitle(), urlString: articleService.getDefaultUrlString())
        }
    }

    func requestArticle(title: String, urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        navigationItem.title = title
        messageView.nowLoading()

        Alamofire.request(url).responseData { [weak self] (response) in
            switch response.result {
            case .success:
                guard let data = response.data,
                      let articles = self?.articleService.parse(data: data) else {
                    self?.messageView.showMessage("記事が見つかりませんでした")
                    return
                }

                if articles.count == 0 {
                    self?.messageView.showMessage("記事が見つかりませんでした")
                    return
                }

                self?.reloadArticle(articles: articles)
                self?.messageView.hide()

            case .failure(let error):
                print(error.localizedDescription)
                self?.messageView.showMessage("記事の読み込みに失敗しました")
            }
        }
    }

    func requestArticleBySelectedKeyword() {
        if let keyword = SideMenuService.getSelectedKeyword(),
           let urlString = articleService.getUrlString(keyword: keyword) {
            requestArticle(title: keyword, urlString: urlString)
        }
    }

    func reloadArticle(articles: [Article]) {
        dataSource = ArticleListTableViewDataSource(articles: articles)
        articleListTableView.dataSource = dataSource
        articleListTableView.reloadData()
    }

    func openArticle(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid url string")
            return
        }

        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
