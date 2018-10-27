
import UIKit

class CalendarDaysCell: UICollectionViewCell {

    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backV.layer.borderColor = UIColor.black.cgColor
        self.backV.layer.borderWidth = 0.5
    }
    
    func setupCell(date: String, indexPath: IndexPath, daysOfPreMonth: Int, daysOfLastMonth: Int) {
        self.dateLabel.text = date
        
        switch indexPath.row {
        case 0..<daysOfPreMonth, daysOfLastMonth...100:
            if (indexPath.row % 7 == 0) {
                self.dateLabel.textColor = UIColor.lightRed()
            } else if (indexPath.row % 7 == 6) {
                self.dateLabel.textColor = UIColor.lightBlue()
            } else {
                self.dateLabel.textColor = UIColor.gray
            }
        case daysOfPreMonth..<daysOfLastMonth:
            if (indexPath.row % 7 == 0) {
                self.dateLabel.textColor = UIColor.red
            } else if (indexPath.row % 7 == 6) {
                self.dateLabel.textColor = UIColor.blue
            } else {
                self.dateLabel.textColor = UIColor.black
            }
        default:
            break
        }
    }

}
