
import UIKit

protocol SendViewDelegate : class {
    func sendViewAttach()
}

class SendView : UIView {

    weak var delegate: SendViewDelegate?

    @IBAction func attach(_ sender: Any) {
        self.delegate?.sendViewAttach()
    }
    
    // MARK: - FOCUS

    @IBOutlet private  var textField: UITextField!
    func removeFocus() {
        self.textField.resignFirstResponder()
    }

}

