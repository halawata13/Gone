import Foundation
import UIKit
import SlideMenuControllerSwift
import Alamofire
import SafariServices

class GnewsListViewController: UIViewController {
    let articleService = GnewsService()

    var articles = [Article]()

    private var imageDownloadsInProgress: [IndexPath: ArticleThumbsDownloader] = [: ]

    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var messageView: MessageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onLeftEdgePanned))
        leftEdgePan.edges = .left
        view.addGestureRecognizer(leftEdgePan)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(onTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "config"), style: .plain, target: self, action: #selector(onTapConfigButton))

        articleListTableView.delegate = self
        articleListTableView.dataSource = self

        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onLongPressedTableViewCell)))

        initArticle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        slideMenuController()?.delegate = self

        // 必要であれば記事を更新する
        if articleService.isNecessaryReloading() {
            requestArticleBySelectedKeyword()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        terminateAllThumbsDownloads()
    }

    deinit {
        terminateAllThumbsDownloads()
    }

    ///
    /// 左からのスワイプ
    ///
    @objc func onLeftEdgePanned(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        slideMenuController()?.openLeft()
    }

    ///
    /// メニューボタンのタップ
    ///
    @objc func onTapMenuButton(_ sender: UIBarButtonItem) {
        slideMenuController()?.openLeft()
    }

    ///
    /// 設定ボタンのタップ
    ///
    @objc func onTapConfigButton(_ sender: UIBarButtonItem) {
        let configViewController = UIStoryboard(name: "Config", bundle: nil).instantiateInitialViewController()!
        present(configViewController, animated: true)
    }

    ///
    /// 記事の長押しでの処理
    ///
    @objc func onLongPressedTableViewCell(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began,
              let indexPath = articleListTableView.indexPathForRow(at: recognizer.location(in: articleListTableView)) else {
            return
        }
        print(indexPath)

        let article = articles[indexPath.row]
        let alertController = UIAlertController(title: article.host, message: nil, preferredStyle: .alert)

        let muteAction = UIAlertAction(title: "このサイトの記事をミュートする", style: .default) { [weak self] (action) in
            MuteService.setMute(host: article.host)
            self?.deleteArticle(host: article.host)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)

        alertController.addAction(muteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    ///
    /// 初回表示時
    ///
    private func initArticle() {
        imageDownloadsInProgress = [: ]

        if let keyword = SideMenuService.getDefaultKeyword(),
           let urlString = SideMenuService.getUrlString(for: keyword) {
            SideMenuService.setSelectedKeyword(keyword)
            requestArticle(title: keyword, urlString: urlString)
        }
    }

    ///
    /// RSSをリクエストする
    ///
    private func requestArticle(title: String, urlString: String) {
        guard let url = URL(string: urlString),
              let keyword = SideMenuService.getSelectedKeyword() else {
            return
        }

        navigationItem.title = title
        messageView.nowLoading()

        Alamofire.request(url).responseData { [weak self] (response) in
            switch response.result {
            case .success:
                guard let data = response.data,
                      let articles = self?.articleService.parse(data: data, keyword: keyword) else {
                    self?.messageView.show(message: "記事が見つかりませんでした")
                    return
                }

                if articles.count == 0 {
                    self?.messageView.show(message: "記事が見つかりませんでした")
                    return
                }

                self?.reloadArticle(articles: articles)
                self?.messageView.hide()

            case .failure(let error):
                print(error.localizedDescription)
                self?.messageView.show(message: "記事の読み込みに失敗しました")
            }

            self?.articleService.doneReloading()
        }
    }

    ///
    /// 選択したキーワードでRSSをリクエストする
    ///
    private func requestArticleBySelectedKeyword() {
        if let keyword = SideMenuService.getSelectedKeyword(),
           let urlString = SideMenuService.getUrlString(for: keyword) {
            requestArticle(title: keyword, urlString: urlString)
        }
    }

    ///
    /// RSSを再リクエストする
    ///
    private func reloadArticle(articles: [Article]) {
        self.articles = articles
        articleListTableView.reloadData()
        imageDownloadsInProgress = [: ]
        loadThumbsImagesForOnscreenRows()
    }

    ///
    /// 表示中の記事をホスト名で非表示にする
    ///
    private func deleteArticle(host: String) {
        var deleteIndexPaths = [IndexPath]()
        var i = 0

        articles = articles.filter {
            if host == $0.host {
                deleteIndexPaths.append(IndexPath(row: i, section: 0))
            }

            i += 1

            return host != $0.host
        }

        articleListTableView.deleteRows(at: deleteIndexPaths, with: .fade)
    }

    ///
    /// 記事を開く
    ///
    private func openArticle(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }

    ///
    /// サムネイル画像のダウンロードを中止する
    ///
    private func terminateAllThumbsDownloads() {
        let allDownloads = imageDownloadsInProgress.values
        for download in allDownloads {
            download.cancel()
        }

        imageDownloadsInProgress.removeAll(keepingCapacity: false)
    }

    ///
    /// サムネイル画像のダウンロードを開始する
    ///
    private func startThumbsDownload(_ article: Article, for indexPath: IndexPath) {
        if imageDownloadsInProgress[indexPath] == nil {
            let downloader = ArticleThumbsDownloader(article: article)
            downloader.completionHandler = { [weak self] in
                self?.articles[indexPath.row].thumbsImage = downloader.article.thumbsImage
                let cell = self?.articleListTableView.cellForRow(at: indexPath) as? ArticleListTableViewCell
                cell?.setThumbsImage(downloader.article.thumbsImage)

                self?.imageDownloadsInProgress.removeValue(forKey: indexPath)
            }

            imageDownloadsInProgress[indexPath] = downloader
            downloader.start()
        }
    }

    ///
    /// 画面に表示されている行のサムネイル画像のダウンロードを開始する
    ///
    private func loadThumbsImagesForOnscreenRows() {
        if !articles.isEmpty,
           let visiblePaths = articleListTableView.indexPathsForVisibleRows {
            visiblePaths.forEach { indexPath in
                let article = articles[indexPath.row]

                if article.thumbsImage == nil {
                    startThumbsDownload(article, for: indexPath)
                }
            }
        }
    }
}

extension GnewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.className, for: indexPath) as! ArticleListTableViewCell
        cell.setArticle(articles[indexPath.row])

        return cell
    }
}

extension GnewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let keyword = SideMenuService.getSelectedKeyword() else {
            return
        }

        let cell = tableView.cellForRow(at: indexPath) as? ArticleListTableViewCell
        cell?.setRead(isRead: true)
        articleService.markAsRead(keyword: keyword, url: articles[indexPath.row].url)

        openArticle(url: articles[indexPath.row].url)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension GnewsListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadThumbsImagesForOnscreenRows()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadThumbsImagesForOnscreenRows()
    }
}

extension GnewsListViewController: SlideMenuControllerDelegate {
    func leftWillClose() {
        if articleService.isNecessaryReloading() {
            requestArticleBySelectedKeyword()

            // スクロールをトップに戻す
            if articles.count > 0 {
                articleListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
}
