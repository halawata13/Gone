import Foundation
import UIKit

class ConfigListTableViewDataSource: NSObject, UITableViewDataSource {
    let data = ConfigService.items

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigListTableViewCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].rawValue

        return cell
    }
}
