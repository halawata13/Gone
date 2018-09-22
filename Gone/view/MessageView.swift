import Foundation
import UIKit

class MessageView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadXib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadXib()
    }

    private func loadXib() {
        Bundle.main.loadNibNamed(MessageView.className, owner: self, options: nil)
        contentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)

        addSubview(contentView)
    }

    func nowLoading() {
        contentView.superview?.isHidden = false
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        messageLabel.isHidden = true
    }

    func showMessage(_ message: String) {
        contentView.superview?.isHidden = false
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        messageLabel.isHidden = false
        messageLabel.text = message
    }

    func hide() {
        contentView.superview?.isHidden = true
    }
}
