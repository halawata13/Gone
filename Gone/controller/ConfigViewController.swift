import Foundation
import UIKit

class ConfigViewController: UIViewController {
    let dataSource = ConfigListTableViewDataSource()

    @IBOutlet weak var configListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "設定"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(onDone))

        configListTableView.dataSource = dataSource
        configListTableView.delegate = self
    }

    @objc func onDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension ConfigViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.data[indexPath.row]

        switch item {
        case .menu:
            let viewController = UIStoryboard(name: "SideMenuManagement", bundle: nil).instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)

        case .mute:
            let viewController = UIStoryboard(name: "MuteManagement", bundle: nil).instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
