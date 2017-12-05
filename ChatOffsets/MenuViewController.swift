
import UIKit

private let LOG_TAG = "MenuViewController"

class MenuViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    SendViewDelegate
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
        // Display chat.
        let chatVC = ChatViewController()
        self.show(chatVC, sender: self)

        // Setup chat send (input) view.
        // Make its height equal to tab bar's one + 20.
        let height = self.tabBarController!.tabBar.frame.size.height
        let view = UIView(frame: CGRect(x:0, y: 0, width: 0, height: height + 20))
        view.embeddedView = self.sendView
        chatVC.sendView = view
    }

    // MARK: - SEND VIEW FOR CHAT

    private var sendView: SendView!

    private func setupSendView() {
        self.sendView = UIView.loadFromNib()
        self.sendView.delegate = self
    }

    func sendViewAttach() {
        // Options.
        let actionDoThis = UIAlertAction(title: "Do this", style: .default)
        let actionDoThat = UIAlertAction(title: "Do that", style: .default)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actions = [actionDoThis, actionDoThat, actionCancel]
        // Action sheet.
        let actionSheet =
            UIAlertController(
                title: "Select anything",
                message: nil,
                preferredStyle: .actionSheet
            )
        for action in actions {
            actionSheet.addAction(action)
        }
        // Display action sheet with options.
        self.navigationController?.present(actionSheet, animated: true, completion: nil)
    }

}

