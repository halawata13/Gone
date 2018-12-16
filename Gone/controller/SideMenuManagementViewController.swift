import Foundation
import UIKit

class SideMenuManagementViewController: UIViewController {
    let sideMenuManagementTableViewDataSource = SideMenuManagementTableViewDataSource()
    
    @IBOutlet weak var sideMenuManagementTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ConfigService.Item.menu.rawValue

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(onTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(onTapDone))

        sideMenuManagementTableView.dataSource = sideMenuManagementTableViewDataSource
        sideMenuManagementTableView.delegate = self
        sideMenuManagementTableView.setEditing(true, animated: false)
    }

    @objc func onTapCancel(_ sender: UIBarButtonItem) {
        sideMenuManagementTableViewDataSource.reservingDeleteKeywords = [String]()
        navigationController?.popViewController(animated: true)
    }

    @objc func onTapDone(_ sender: UIBarButtonItem) {
        GnewsService().removeMarkingAsRead(for: sideMenuManagementTableViewDataSource.reservingDeleteKeywords)
        SideMenuService.setKeywords(sideMenuManagementTableViewDataSource.data)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapAddition(_ sender: UIButton) {
        let alertController = UIAlertController(title: "キーワード追加", message: "追加するキーワードを入力してください", preferredStyle: .alert)
        alertController.addTextField()

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let textField = alertController.textFields?.first else {
                return
            }

            if let text = textField.text,
               !text.isEmpty {
                self?.sideMenuManagementTableViewDataSource.addKeyword(keyword: text)
                self?.sideMenuManagementTableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

extension SideMenuManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
