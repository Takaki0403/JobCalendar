
import UIKit

class CalendarDaysCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(date: String) {
        self.dateLabel.text = date
        self.backgroundColor = .lightGray
    }

}
