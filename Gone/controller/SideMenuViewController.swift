import Foundation
import UIKit
import SlideMenuControllerSwift

class SideMenuViewController: UIViewController {
    var dataSource: SideMenuTableViewDataSource!

    @IBOutlet weak var sideMenuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuTableView.register(UINib(nibName: SideMenuTableViewCell.className, bundle: nil), forCellReuseIdentifier: SideMenuTableViewCell.className)
        sideMenuTableView.delegate = self

        reloadSideMenu()
    }

    ///
    /// サイドメニューを更新する
    ///
    func reloadSideMenu() {
        dataSource = SideMenuTableViewDataSource()
        sideMenuTableView.dataSource = dataSource
        sideMenuTableView.reloadData()
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let keyword = dataSource.data[indexPath.section][indexPath.row]
        SideMenuService.setSelectedKeyword(keyword)
        GnewsService().requireReloading()

        slideMenuController()?.closeLeft()
    }
}
