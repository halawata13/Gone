import UIKit

class ArticleThumbsDownloader: NSObject, NSURLConnectionDataDelegate {
    var completionHandler: (() -> Void)?
    var article: Article

    private var sessionTask: URLSessionDataTask?

    init(article: Article) {
        self.article = article
    }

    ///
    /// サムネイル画像のダウンロードを開始する
    ///
    func start() {
        guard let thumbsUrl = article.thumbsUrl else {
            return
        }

        let request = URLRequest(url: thumbsUrl)

        sessionTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }

            OperationQueue.main.addOperation {
                self?.article.thumbsImage = image
                self?.completionHandler?()
            }
        }

        sessionTask?.resume()
    }

    ///
    /// サムネイル画像のダウンロードを中止する
    ///
    func cancel() {
        sessionTask?.cancel()
        sessionTask = nil
    }
}
