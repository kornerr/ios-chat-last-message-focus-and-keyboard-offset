
import UIKit

class TableViewCellTemplate<ItemView : UIView> : UITableViewCell {

    var itemView: ItemView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Load and embed item view.
        self.itemView = UIView.loadFromNib()
        self.contentView.embeddedView = self.itemView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("TableViewCellTemplate. ERROR init(coder:) has not been implemented")
    }

}

