import Foundation
import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        contentEdgeInsets = UIEdgeInsets(top: frame.size.height / 4, left: frame.size.height / 2, bottom: frame.size.height / 4, right: frame.size.height / 2)

        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }
}
