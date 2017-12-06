
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

    // MARK: - STATE
    
    var state = KeyboardState.None
    var stateChanged: KeyboardCallback? = nil

    @objc func keyboardDidHide(notification: Notification) {
        self.state = .Hidden
        if let callback = self.stateChanged {
            callback()
        }
    }

    @objc func keyboardDidShow(notification: Notification) {
        self.state = .Shown
        if let callback = self.stateChanged {
            callback()
        }
    }

    // MARK: - HEIGHT

    var height: CGFloat = 0
    var heightChanged: KeyboardCallback? = nil
    
    @objc func keyboardWillHide(notification: Notification) {
        NSLog("\(LOG_TAG) will hide")
        self.height = 0
        NSLog("\(LOG_TAG) keyboard height: '\(height)'")
        if let callback = self.heightChanged {
            callback()
        }
    }

    @objc func keyboardWillShow(notification: Notification) {
        NSLog("\(LOG_TAG) will show")
        let frameEnd =
            notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        self.height = frameEnd.cgRectValue.height
        NSLog("\(LOG_TAG) keyboard height: '\(self.height)'")
        if let callback = self.heightChanged {
            callback()
        }
    }

    private func printFrame(_ notification: Notification) {
        let frameBegin =
            notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let frameEnd =
            notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        NSLog("\(LOG_TAG) frame begin: '\(frameBegin)' frame end: '\(frameEnd)'")
    }

}

