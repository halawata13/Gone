import Foundation
import UIKit

class SideMenuTableViewDataSource: NSObject, UITableViewDataSource {
    let data: [String]

    override init() {
        self.data = SideMenuService.getAllKeywords()
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
}
