
import UIKit

class TextItemView : UIView {

    // MARK: - SETUP
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAvatar()
        self.setupText()
    }

    // MARK: - AVATAR
    
    @IBOutlet private var avatarImageView: UIImageView!
    
    private func setupAvatar() {
        // Round avatar.
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
    }

    // MARK: - PROPERTY TEXT

    var text: String {
        get { return _text }
        set {
            _text = newValue
            self.updateText()
        }
    }

    private var _text = ""
    
    @IBOutlet private var messageBubbleView: UIView!
    @IBOutlet private var messageTextLabel: UILabel!

    private func setupText() {
        // Bubble round corners.
        self.messageBubbleView.layer.cornerRadius = 14
        self.messageBubbleView.clipsToBounds = true
    }

    private func updateText() {
        self.messageTextLabel.text = self.text
    }
    
}

