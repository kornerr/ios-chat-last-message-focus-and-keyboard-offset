
import UIKit

public extension UIView {

    var embeddedView : UIView? {
        get {
            // We only work with single or no subview.
            if (self.subviews.count > 1) {
                return nil
            }
            return self.subviews.first
        }
        set {
            // We only work with single or no subview.
            if (self.subviews.count > 1) {
                return
            }
            if let subview = self.subviews.first {
                // Already embedded.
                if (newValue == subview) {
                    // Do nothing.
                    return
                }
                // Remove old subview.
                subview.removeFromSuperview()
            }
            if let view = newValue {
                // Add new subview.
                self.embedView(view)
            }
        }
    }

    func embedView(_ other: UIView) {
        self.addSubview(other)
        other.translatesAutoresizingMaskIntoConstraints = false
        other.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        other.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        other.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        other.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }

}

