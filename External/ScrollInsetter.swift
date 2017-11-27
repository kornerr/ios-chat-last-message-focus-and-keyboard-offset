
import UIKit

// Manage scroll view insets for when keyboard is shown and hidden.
class ScrollInsetter : NSObject {

    init(scrollView: UIScrollView) {
        super.init()
        self.scrollView = scrollView
        self.origInsets = scrollView.contentInset
        self.setupScrollInsetter()
    }

    var keyboard: Keyboard!
    private var origInsets = UIEdgeInsets()
    private weak var scrollView: UIScrollView!

    private func setupScrollInsetter() {
        self.keyboard = Keyboard()
        self.keyboard.heightChanged = { [unowned self] in
            var insets = self.origInsets
            insets.bottom += self.keyboard.height
            self.scrollView.contentInset = insets
            self.scrollView.scrollIndicatorInsets = insets
        }
    }

}

