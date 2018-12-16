import Foundation
import UIKit
import SlideMenuControllerSwift

class ArticleListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onLeftEdgePanned))
        leftEdgePan.edges = .left
        view.addGestureRecognizer(leftEdgePan)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(onTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "config"), style: .plain, target: self, action: #selector(onTapConfigButton))
    }

    @objc func onLeftEdgePanned(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        slideMenuController()?.openLeft()
    }

    @objc func onTapMenuButton(_ sender: UIBarButtonItem) {
        slideMenuController()?.openLeft()
    }

    @objc func onTapConfigButton(_ sender: UIBarButtonItem) {
        let configViewController = UIStoryboard(name: "Config", bundle: nil).instantiateInitialViewController()!
        present(configViewController, animated: true)
    }
}
