import Foundation
import UIKit

class DateRangeManagementViewController: UIViewController {
    let dataSource = DateRangeManagementTableViewDataSource()

    @IBOutlet weak var dataRangeManagementTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ConfigService.Item.dateRange.rawValue

        dataRangeManagementTableView.dataSource = dataSource
        dataRangeManagementTableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let dateRange = DateRangeService.items
        let selectedDateRange = DateRangeService.getDateRange()

        for (i, item) in dateRange.enumerated() {
            if item == selectedDateRange {
                // 現在選択されているものにチェックマーク
                let cell = dataRangeManagementTableView.cellForRow(at: IndexPath(row: i, section: 0))
                cell?.accessoryType = .checkmark

                // 他の項目を選択時にチェックが外れるように選択状態にしておく
                dataRangeManagementTableView.selectRow(at: IndexPath(row: i, section: 0), animated: false, scrollPosition: .bottom)

                break
            }
        }
    }
}

extension DateRangeManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateRange = dataSource.data[indexPath.row]

        // チェックマークをつける
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark

        // 記事の更新が必要であることを通知
        GnewsService().requireReloading()

        // 設定を保存
        DateRangeService.setDateRange(dateRange)

        // 設定トップ画面の値を更新する
        if let configViewController = navigationController?.viewControllers.first as? ConfigViewController {
            configViewController.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // チェックマークを外す
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
