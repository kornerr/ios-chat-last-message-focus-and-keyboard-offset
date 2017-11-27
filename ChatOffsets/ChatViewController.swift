
import UIKit

class ChatViewController:
    UIViewController,
    UITableViewDataSource
{

    // MARK: - SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chat"
        self.setupTableView()
    }

    // MARK: - TABLE VIEW
    
    @IBOutlet private var tableView: UITableView!
    private let items = [
        "This is a simple and short line of text",
        "Let us try to have more length with these funny symbols we call letters and words and... sentences!",
        "Time for quotes",
        "Beauty is the highest degree of feasibility, the degree of matching and harmonic combination " +
        "of contradictory elements in any device, any thing, any body... Each beautiful line, form, " +
        "combination is a feasible solution, developed by nature over millions of years of natural " +
        "selection, or found by man in his quest for the beauty of things, i.e. for the correctness of the things. " +
        "Beauty is itself a general pattern that levels the chaos, beauty is the great middle the appropriate versatility... " +
        "-- I. Efremov"
    ]

    private func setupTableView() {
        self.tableView.dataSource = self

        self.tableView.register(
            TextItemType.self,
            forCellReuseIdentifier: TextItemId
        )
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: TextItemId,
                for: indexPath)
            as! TextItemType
        cell.itemView.text = self.items[indexPath.row]
        return cell
    }

    // MARK: - TEXT ITEM

    private let TextItemId = "TextItem"
    private typealias TextItemType = TableViewCellTemplate<TextItemView>

    private func cellTextItem(at indexPath: IndexPath) -> TextItemType {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: TextItemId,
                for: indexPath
            )
            as! TextItemType
        return cell
    }

}

