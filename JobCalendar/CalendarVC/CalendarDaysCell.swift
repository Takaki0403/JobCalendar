
import UIKit
import CalculateCalendarLogic

class CalendarDaysCell: UICollectionViewCell {

    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backV.layer.borderColor = UIColor.black.cgColor
        self.backV.layer.borderWidth = 0.5
    }
    
    func setupCell(year: Int, month: Int, date: String, indexPath: IndexPath, daysOfNextMonth: Int, daysOfLastMonth: Int) {
        let calculateCalendarLogic = CalculateCalendarLogic()
        let dateManager = DateManager()
        let nextYAndM = dateManager.decideMonthAndYear(year: year, month: month - 1)
        let lastYAndM = dateManager.decideMonthAndYear(year: year, month: month + 1)
        
        self.dateLabel.text = date
        
        switch indexPath.row {
        case 0..<daysOfNextMonth:
            if (indexPath.row % 7 == 0) || calculateCalendarLogic.judgeJapaneseHoliday(year: nextYAndM.year, month: nextYAndM.month, day: Int(date)!) {
                self.dateLabel.textColor = UIColor.lightRed()
            } else if (indexPath.row % 7 == 6) {
                self.dateLabel.textColor = UIColor.lightBlue()
            } else {
                self.dateLabel.textColor = UIColor.gray
            }
        case daysOfLastMonth...100:
            if (indexPath.row % 7 == 0) || calculateCalendarLogic.judgeJapaneseHoliday(year: lastYAndM.year, month: lastYAndM.month, day: Int(date)!) {
                self.dateLabel.textColor = UIColor.lightRed()
            } else if (indexPath.row % 7 == 6) {
                self.dateLabel.textColor = UIColor.lightBlue()
            } else {
                self.dateLabel.textColor = UIColor.gray
            }
        case daysOfNextMonth..<daysOfLastMonth:
            if (indexPath.row % 7 == 0) || calculateCalendarLogic.judgeJapaneseHoliday(year: year, month: month, day: Int(date)!){
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
