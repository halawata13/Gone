import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let articleService = GnewsService()
        navigationBar.barTintColor = articleService.getThemeColor()
        navigationBar.tintColor = articleService.getTintColor()
        navigationBar.titleTextAttributes = [
            .foregroundColor: articleService.getTintColor()
        ]
    }
}
