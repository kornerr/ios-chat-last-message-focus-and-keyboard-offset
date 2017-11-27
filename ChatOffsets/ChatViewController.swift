
import UIKit

private let LOG_TAG = "ChatViewController"

class ChatViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{

    // MARK: - SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chat"
        self.setupItems()
        self.setupTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // The first reloadData() call happens after laying out subviews.
        // So this is the best place to scroll to bottom.
        self.scrollToBottom()
    }

    // MARK: - ITEMS
    
    private var items = [Item]()
    
    private func setupItems() {

        self.items = [
            TextItem(
                text: "This is a simple and short line of text"
            ),
            TextItem(
                text: "Let us try to have more length with these funny symbols we call letters and words and... sentences!"
            ),
            TextItem(text: "Time for quotes"),
            TextItem(text:
                "Beauty is the highest degree of feasibility, the degree of matching and harmonic combination " +
                "of contradictory elements in any device, any thing, any body... Each beautiful line, form, " +
                "combination is a feasible solution, developed by nature over millions of years of natural " +
                "selection, or found by man in his quest for the beauty of things, i.e. for the correctness of the things. " +
                "Beauty is itself a general pattern that levels the chaos, beauty is the great middle the appropriate versatility... " +
                "-- I. Efremov"
            ),
            TextItem(
                text: "We still need more lines to make this sample look closer to reality"
            ),
            TextItem(
                text: "It is a good excercise to create isolated applications that depict solutions to specific problems, I think"
            ),
            TextItem(
                text: "So automatic dimensions thing works fine, doesn't it? Why didn't it work then for me last time?"
            )
        ]
    }

    // MARK: - TABLE VIEW

    @IBOutlet private var tableView: UITableView!

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

#if USE_DYNAMIC_CELL_HEIGHT
        self.setupTableViewCellHeight()
#endif // USE_DYNAMIC_CELL_HEIGHT

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
        return self.cellTextItem(at: indexPath)
    }

    /*
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return self.cellTextItemHeight(for: indexPath)
    }
    */

#if USE_DYNAMIC_CELL_HEIGHT
    // MARK: - TABLE VIEW DYNAMIC CELL HEIGHT
    // Cell height caching: https://stackoverflow.com/a/33397350/3404710
    
    private var cachedCellHeights = [IndexPath : CGFloat]()

    func setupTableViewCellHeight() {
        // Make cells self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        // Retrieve cell height if it has been visible at least once.
        if let height = self.cachedCellHeights[indexPath] {
            return height
        }
        // The first display uses automatic calculation.
        else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        // Cache cell height.
        self.cachedCellHeights[indexPath] = cell.frame.size.height
    }
#endif // USE_DYNAMIC_CELL_HEIGHT

    // MARK: - TEXT ITEM

    private let TextItemId = "TextItem"
    private typealias TextItemType = TableViewCellTemplate<TextItemView>

    private func cellTextItem(at indexPath: IndexPath) -> TextItemType {
        NSLog("\(LOG_TAG) cellTextItem at '\(indexPath)'")
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: TextItemId,
                for: indexPath
            )
            as! TextItemType
        let item = self.items[indexPath.row] as! TextItem
        cell.itemView.text = item.text
        return cell
    }

    private func cellTextItemHeight(for indexPath: IndexPath) -> CGFloat {
        return 200
    }

    // MARK: - SCROLLING TO BOTTOM

    private func scrollToBottom() {
        NSLog("\(LOG_TAG) scroll to bottom")
        let lastRow = IndexPath(row: self.items.count - 1, section: 0)
        self.tableView.scrollToRow(at: lastRow, at: .top, animated: true)
    }

}

