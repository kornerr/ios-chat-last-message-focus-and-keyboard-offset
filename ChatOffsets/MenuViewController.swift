
import UIKit

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
    }

}

