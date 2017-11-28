
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
        // Display chat.
        let chatVC = ChatViewController()
        self.show(chatVC, sender: self)

        // Setup chat send (input) view.
        // Make its height twice the tab bar's one.
        let height = self.tabBarController!.tabBar.frame.size.height
        let view = UIView(frame: CGRect(x:0, y: 0, width: 0, height: height * 2))
        view.embeddedView = self.sendView
        chatVC.sendView = view
    }

    // MARK: - SEND VIEW FOR CHAT

    private var sendView: SendView!

    private func setupSendView() {
        self.sendView = UIView.loadFromNib()
    }

}

