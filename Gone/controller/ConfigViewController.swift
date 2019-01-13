import Foundation
import UIKit
import SlideMenuControllerSwift

class ConfigViewController: UIViewController {
    let dataSource = ConfigListTableViewDataSource()

    @IBOutlet weak var configListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "設定"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(onDone))

        configListTableView.delegate = self

        reloadData()
    }

    ///
    /// 完了ボタンのタップ
    ///
    @objc func onDone(_ sender: UIBarButtonItem) {
        // サイドメニューを更新する
        ((presentingViewController as? SlideMenuController)?.leftViewController as? SideMenuViewController)?.reloadSideMenu()

        dismiss(animated: true)
    }

    ///
    /// 項目を更新する
    ///
    func reloadData() {
        configListTableView.dataSource = dataSource
        configListTableView.reloadData()
    }
}

extension ConfigViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.data[indexPath.row]

        switch item {
        // キーワード
        case .menu:
            let viewController = UIStoryboard(name: "SideMenuManagement", bundle: nil).instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)

        // ミュート
        case .mute:
            let viewController = UIStoryboard(name: "MuteManagement", bundle: nil).instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)

        // 記事の取得期間
        case .dateRange:
            let viewController = UIStoryboard(name: "DateRangeManagement", bundle: nil).instantiateInitialViewController()!
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
