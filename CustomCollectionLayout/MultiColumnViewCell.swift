import UIKit


class MultiColumnViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.whiteColor()
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.font = UIFont.systemFontOfSize(13)
    }
}