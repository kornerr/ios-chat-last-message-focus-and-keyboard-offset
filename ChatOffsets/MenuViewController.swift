
import UIKit

private let LOG_TAG = "MenuViewController"

class MenuViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{

    // MARK: - SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSendView()
    }

    // MARK: - TABLE VIEW
    
    @IBOutlet private var tableView: UITableView!

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "Default" 
        )
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: "Default",
                for: indexPath)
        cell.textLabel?.text = "select me № \(indexPath.row)"
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // Display chat VC.
        let chatVC = ChatViewController()
        chatVC.sendView = self.sendView
        self.show(chatVC, sender: self)
    }

    // MARK: - SEND VIEW FOR CHAT

    private var sendView: SendView!

    private func setupSendView() {
        self.sendView = UIView.loadFromNib()
        self.sendView.autoresizingMask = .flexibleHeight
        //self.sendView.translatesAutoresizingMaskIntoConstraints = false
        // Set its height to tab bar height.
        if let height = self.tabBarController?.tabBar.frame.size.height {
            //self.sendView.heightAnchor.constraint(equalToConstant: height).isActive = true
            /*
            // Find current height anchor.
            let constraints = self.sendView.constraints.filter { $0.firstAttribute == .height }
            NSLog("\(LOG_TAG) constraints: '\(constraints)'")
            if let constraint = constraints.first {
                constraint.constant = height
                NSLog("\(LOG_TAG) set height to tab bar")
            }
            */
        }
    }

}

