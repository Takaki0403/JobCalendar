
import UIKit

class CalendarDaysCell: UICollectionViewCell {


    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backV.layer.borderColor = UIColor.black.cgColor
        self.backV.layer.borderWidth = 0.2
    }
    
    func setupCell(date: String) {
        self.dateLabel.text = date
        self.backgroundColor = .lightGray
    }

}
