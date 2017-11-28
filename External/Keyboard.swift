
import UIKit

private let LOG_TAG = "Keyboard"

enum KeyboardState {
    case None
    case Shown
    case Hidden
}

typealias KeyboardCallback = () -> Void

// Keyboard state and height notifier.
class Keyboard : NSObject {

    // MARK: - SETUP 

    override init() {
        super.init()
        // Track height.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil
        )

        // Track state.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardDidShow(notification:)),
            name: .UIKeyboardDidShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardDidHide(notification:)),
            name: .UIKeyboardDidHide,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - NOTIFICATION VALIDITY

    private func isNotificationValid(_ notification: Notification) -> Bool {
        return true
        // Detect invalid keyboard show/hide reports.
        // Invalid ones have the same FrameBegin/FrameEnd values.
        if
            let frameBegin = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
            let frameEnd = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        {
            return frameBegin.cgRectValue != frameEnd.cgRectValue
        }
        return false
    }

    // MARK: - STATE
    
    var state = KeyboardState.None
    var stateChanged: KeyboardCallback? = nil

    @objc func keyboardDidHide(notification: Notification) {
        if (!self.isNotificationValid(notification)) {
            return
        }

        self.state = .Hidden
        if let callback = self.stateChanged {
            callback()
        }
    }

    @objc func keyboardDidShow(notification: Notification) {
        if (!self.isNotificationValid(notification)) {
            return
        }

        self.state = .Shown
        if let callback = self.stateChanged {
            callback()
        }
    }

    // MARK: - HEIGHT

    var height: CGFloat = 0
    var heightChanged: KeyboardCallback? = nil
    
    @objc func keyboardWillHide(notification: Notification) {
        if (!self.isNotificationValid(notification)) {
            return
        }

        self.height = 0
        if let callback = self.heightChanged {
            callback()
        }
    }

    @objc func keyboardWillShow(notification: Notification) {
        if (!self.isNotificationValid(notification)) {
            return
        }

        let frameBegin =
            notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let frameEnd =
            notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        self.height = frameBegin.cgRectValue.minY - frameEnd.cgRectValue.minY
        if let callback = self.heightChanged {
            callback()
        }
    }

}

