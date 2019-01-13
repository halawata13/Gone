import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var markerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        markerView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
        markerView.backgroundColor = SideMenuService.getColor(for: title)
    }
}
