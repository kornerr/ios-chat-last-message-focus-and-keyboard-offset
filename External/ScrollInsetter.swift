
import UIKit

private let LOG_TAG = "ScrollInsetter"

typealias ScrollInsetterCallback = () -> Void

// Manage scroll view insets for when keyboard is shown and hidden.
class ScrollInsetter : NSObject {

    init(scrollView: UIScrollView) {
        super.init()
        self.scrollView = scrollView
        self.origInsets = scrollView.contentInset
        self.setupScrollInsetter()
    }

    var scrolled: ScrollInsetterCallback? = nil

    var keyboard: Keyboard!
    private var origInsets = UIEdgeInsets()
    private weak var scrollView: UIScrollView!

    private func setupScrollInsetter() {
        self.keyboard = Keyboard()
        self.keyboard.heightChanged = { [unowned self] in
            NSLog("\(LOG_TAG) keyboard height changed to '\(self.keyboard.height)'")
            var insets = self.origInsets
            insets.bottom += self.keyboard.height
            self.scrollView.contentInset = insets
            self.scrollView.scrollIndicatorInsets = insets
            if let callback = self.scrolled {
                callback()
            }
        }
    }

}

