import Foundation
import UIKit
import SlideMenuControllerSwift

class SideMenuViewController: UIViewController {
    var sideMenuTableViewDataSource: SideMenuTableViewDataSource!

    @IBOutlet weak var sideMenuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sideMenuTableViewDataSource = SideMenuTableViewDataSource()
        sideMenuTableView.dataSource = sideMenuTableViewDataSource
        sideMenuTableView.reloadData()
    }
}

extension SideMenuViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = sideMenuTableViewDataSource.data[indexPath.row]
        SideMenuService.setSelectedKeyword(keyword)

        slideMenuController()?.closeLeft()
    }
}
