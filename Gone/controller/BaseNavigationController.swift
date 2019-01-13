import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.gray
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
