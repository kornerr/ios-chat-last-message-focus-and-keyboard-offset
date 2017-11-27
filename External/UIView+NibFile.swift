
import UIKit

public extension UIView {

    class func loadFromNib<T>() -> T? {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        return objects.first as? T
    }

}

