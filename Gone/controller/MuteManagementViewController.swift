import Foundation
import UIKit

class MuteManagementViewController: UIViewController {
    let dataSource = MuteManagementTableViewDataSource()

    @IBOutlet weak var muteManagementTableView: UITableView!
    @IBOutlet weak var messageView: MessageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ConfigService.Item.mute.rawValue

        muteManagementTableView.dataSource = dataSource
        muteManagementTableView.delegate = self
        muteManagementTableView.setEditing(true, animated: false)

        navigationController?.delegate = self

        // ミュートしているサイトがなければメッセージを出す
        if dataSource.data.count == 0 {
            messageView.show(message: "ミュートしているサイトはありません。\n記事を長押しして記事のサイトをミュートにすることができます。", image: UIImage(named: "mute"))
        } else {
            messageView.hide()
        }
    }
}

extension MuteManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension MuteManagementViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 前画面に戻るときに設定を保存
        if viewController is ConfigViewController {
            MuteService.setMutes(hosts: dataSource.data)
            GnewsService().requireReloading()
        }
    }
}
