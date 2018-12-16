import Foundation
import UIKit

class DateRangeManagementTableViewDataSource: NSObject, UITableViewDataSource {
    let data = DateRangeService.items

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateRangeManagementTableViewCell", for: indexPath)
        let dataRange = data[indexPath.row]
        cell.textLabel?.text = dataRange.rawValue

        return cell
    }
}
