import UIKit

class ConfigNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UIColor(hue: 231 / 360, saturation: 0, brightness: 0.96, alpha: 1)
        navigationBar.tintColor = UIColor.gray
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
