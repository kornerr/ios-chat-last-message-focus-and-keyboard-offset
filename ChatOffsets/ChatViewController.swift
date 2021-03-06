
import UIKit

private let LOG_TAG = "ChatViewController"

class ChatViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{

    // MARK: - SETUP

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide tab bar.
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show tab bar.
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToBottom(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chat"
        self.setupItems()
        self.setupTableView()
        self.addItemAfterDelay()
        self.setupSendView()
        self.setupOffsets()
        self.setupKeyboardScrolling()
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
            ImageItem(image: UIImage(named: "User")!),
            TextItem(
                text: "We still need more lines to make this sample look closer to reality"
            ),
            ImageItem(image: UIImage(named: "User")!),
            TextItem(
                text: "It is a good excercise to create isolated applications that depict solutions to specific problems, I think"
            ),
            ImageItem(image: UIImage(named: "User")!),
            ImageItem(image: UIImage(named: "User")!),
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

        self.setupTableViewCellHeight()

        self.tableView.register(
            TextItemType.self,
            forCellReuseIdentifier: TextItemId
        )
        self.tableView.register(
            ImageItemType.self,
            forCellReuseIdentifier: ImageItemId
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
        let item = self.items[indexPath.row]
        if (item is TextItem) {
            return self.cellTextItem(at: indexPath)
        }
        return self.cellImageItem(at: indexPath)
    }

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
        let item = self.items[indexPath.row] as! TextItem
        cell.itemView.text = item.text
        return cell
    }

    // MARK: - IMAGE ITEM

    private let ImageItemId = "ImageItem"
    private typealias ImageItemType = TableViewCellTemplate<ImageItemView>

    private func cellImageItem(at indexPath: IndexPath) -> ImageItemType {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: ImageItemId,
                for: indexPath
            )
            as! ImageItemType
        let item = self.items[indexPath.row] as! ImageItem
        cell.itemView.image = item.image
        return cell
    }

    // MARK: - SCROLLING TO BOTTOM

    private func scrollToBottom(animated: Bool) {
        NSLog("\(LOG_TAG) scroll to bottom")
        let lastRow = IndexPath(row: self.items.count - 1, section: 0)
        self.tableView.scrollToRow(at: lastRow, at: .top, animated: animated)
    }

    private func addItemAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NSLog("\(LOG_TAG) adding item after delay")
            self.items.append(
                TextItem(
                    text: "Here's another line to see if scrolling to bottom still works"
                )
            )
            self.tableView.reloadData()
            self.scrollToBottom(animated: true)
        }
    }

    // MARK: - SEND VIEW
    
    weak var sendView: SendView?

    @IBOutlet private var sendContainerView: UIView!
    
    private func setupSendView() {
        self.sendContainerView.embeddedView = self.sendView
    }

    // MARK: - OFFSETS

    private func setupOffsets() {
        // iOS 10 and iOS 11 have different offset calcuation algorithms.
        // Do special magic for iOS 10.
        if #available(iOS 11, *) {
            // Do nothing.
        }
        else {
            if let tabBar = self.tabBarController?.tabBar {
                var inset = self.tableView.contentInset
                inset.bottom = -tabBar.frame.size.height
                self.tableView.contentInset = inset
            }
        }
    }

    // MARK: - KEYBOARD SCROLLING

    private var keyboard: Keyboard!
    @IBOutlet private var sendViewBottomConstraint: NSLayoutConstraint!

    private func setupKeyboardScrolling() {
        self.keyboard = Keyboard()

        // Lift/lower send view based on keyboard height.
        let keyboardAnimation = { [unowned self] in
            self.sendViewBottomConstraint.constant = self.keyboard.height
            self.view.layoutIfNeeded()
        }
        // Scroll to bottom after animation.
        let keyboardCompletion: (Bool) -> Void = { [unowned self] _ in
            self.scrollToBottom(animated: true)
        }

        // React to keyboard height changes.
        self.keyboard.heightChanged = {
            UIView.animate(
                withDuration: 0.2,
                animations: keyboardAnimation,
                completion: keyboardCompletion
            )
        }

        // Hide keyboard on tap.
        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(self.hideKeyboard(_:))
            )
        self.tableView.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        self.sendView?.removeFocus()
    }
    
}

