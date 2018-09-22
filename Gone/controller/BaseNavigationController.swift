import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationBar.barTintColor = GnewsService().getThemeColor()
    }
}
