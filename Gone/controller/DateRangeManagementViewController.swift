import Foundation
import UIKit

class DateRangeManagementViewController: UIViewController {
    let dataRangeManagementTableViewDataSource = DateRangeManagementTableViewDataSource()

    @IBOutlet weak var dataRangeManagementTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ConfigService.Item.dateRange.rawValue

        dataRangeManagementTableView.dataSource = dataRangeManagementTableViewDataSource
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
        let dateRange = dataRangeManagementTableViewDataSource.data[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark

        GnewsService().requireReloading()

        DateRangeService.setDateRange(dateRange)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
