import Foundation
import UIKit

class MuteManagementViewController: UIViewController {
    let muteManagementTableViewDataSource = MuteManagementTableViewDataSource()

    @IBOutlet weak var muteManagementTableView: UITableView!
    @IBOutlet weak var messageView: MessageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "ミュート設定"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(onTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(onTapDone))

        muteManagementTableView.dataSource = muteManagementTableViewDataSource
        muteManagementTableView.setEditing(true, animated: false)

        if muteManagementTableViewDataSource.data.count == 0 {
            messageView.show(message: "ミュートしているサイトはありません。\n記事を長押ししてそのサイトをミュートにすることができます。")
        } else {
            messageView.hide()
        }
    }

    @objc func onTapCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @objc func onTapDone(_ sender: UIBarButtonItem) {
        MuteService.setMutes(hosts: muteManagementTableViewDataSource.data)
        navigationController?.popViewController(animated: true)
    }
}
