
import UIKit

class ImageItemView : UIView {

    // MARK: - SETUP
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAvatar()
        self.setupImage()
    }

    @IBOutlet private var avatarImageView: UIImageView!

    private func setupAvatar() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
    }

    // MARK: - PROPERTY IMAGE

    var image: UIImage? {
        get { return _image }
        set {
            _image = newValue
            self.updateImage()
        }
    }

    private var _image: UIImage? = nil
    
    @IBOutlet private var messageBubbleView: UIView!
    @IBOutlet private var messageImageView: UIImageView!

    private func setupImage() {
        // Round corners.
        self.messageBubbleView.layer.cornerRadius = 14
    }

    private func updateImage() {
        self.messageImageView.image = self.image
    }
    
}

