import Foundation
import UIKit

class SideMenuManagementTableViewDataSource: NSObject, UITableViewDataSource {
    var data = SideMenuService.getEditableKeywords()

    func addKeyword(keyword: String) {
        data.append(keyword)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuManagementTableViewCell", for: indexPath)

        if indexPath.row == data.count {
            cell.textLabel?.text = "追加する"
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == data.count {
            return false
        }

        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == data.count {
            return false
        }

        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let targetData = data[sourceIndexPath.row]
        if let index = data.index(of: targetData) {
            data.remove(at: index)
            data.insert(targetData, at: destinationIndexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 削除
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
