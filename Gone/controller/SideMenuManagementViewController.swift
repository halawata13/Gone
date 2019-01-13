import Foundation
import UIKit

class SideMenuManagementViewController: UIViewController {
    let dataSource = SideMenuManagementTableViewDataSource()
    
    @IBOutlet weak var sideMenuManagementTableView: UITableView!
    @IBOutlet weak var messageView: MessageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ConfigService.Item.menu.rawValue

        sideMenuManagementTableView.dataSource = dataSource
        sideMenuManagementTableView.delegate = self
        sideMenuManagementTableView.setEditing(true, animated: false)

        navigationController?.delegate = self

        // キーワードがなければメッセージを出す
        if dataSource.data.count == 0 {
            messageView.show(message: "登録されているキーワードはありません。\nここで登録したキーワードはサイドメニューに表示されます。", usingOkButton: true, image: UIImage(named: "keyword"))
        } else {
            messageView.hide()
        }
    }

    ///
    /// 追加ボタンのタップ
    ///
    @IBAction func onTapAddition(_ sender: UIButton) {
        let alertController = UIAlertController(title: "キーワード追加", message: "追加するキーワードを入力してください", preferredStyle: .alert)
        alertController.addTextField()

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let textField = alertController.textFields?.first else {
                return
            }

            if let text = textField.text,
               !text.isEmpty {
                self?.dataSource.addKeyword(keyword: text)
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension SideMenuManagementViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 前画面に戻るときに設定を保存
        if viewController is ConfigViewController {
            GnewsService().removeMarkingAsRead(for: dataSource.reservingDeleteKeywords)
            SideMenuService.setCustomKeywords(dataSource.data)
        }
    }
}
