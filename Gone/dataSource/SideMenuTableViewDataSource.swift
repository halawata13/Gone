import Foundation
import UIKit

class SideMenuTableViewDataSource: NSObject, UITableViewDataSource {
    let sections: [String]
    let data: [[String]]

    override init() {
        let sideMenu = SideMenuService.getSideMenu()
        sections = sideMenu.sections
        data = sideMenu.items

        super.init()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.className, for: indexPath) as! SideMenuTableViewCell
        cell.setTitle(data[indexPath.section][indexPath.row])

        return cell
    }
}
