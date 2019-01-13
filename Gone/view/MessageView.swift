import Foundation
import UIKit

class MessageView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    
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
        messageView.isHidden = true
        okButton.isHidden = true
        imageView.image = nil
    }

    func show(message: String, usingOkButton: Bool = false, image: UIImage? = nil) {
        contentView.superview?.isHidden = false
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        messageView.isHidden = false
        messageView.text = message
        okButton.isHidden = !usingOkButton
        imageView.image = image

        let textHeight = messageView.sizeThatFits(CGSize(width: messageView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        messageViewHeightConstraint.constant = textHeight
    }

    func hide() {
        contentView.superview?.isHidden = true
    }

    @IBAction func tapOkButton(_ sender: UIButton) {
        hide()
    }
}
