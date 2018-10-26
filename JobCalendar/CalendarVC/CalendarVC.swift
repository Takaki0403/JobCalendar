import UIKit

enum CalendarCellName: String {
    case days = "CalendarDaysCell"
    case week = "CalendarWeekCell"
}

class CalendarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var calendarCollection: UICollectionView!
    let cellMargin: CGFloat = 0
    let weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollection.register(UINib(nibName: CalendarCellName.days.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.days.rawValue)
        calendarCollection.register(UINib(nibName: CalendarCellName.week.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.week.rawValue)
    }
    
    
}

extension CalendarVC {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if indexPath.section == 0 {
            let weekCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.week.rawValue, for: indexPath)
            if let weekCell = weekCell as? CalendarWeekCell {
                weekCell.setupCell(week: weeks[indexPath.row])
            }
            return weekCell
        } else {
            let daysCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.days.rawValue, for: indexPath)
            if let daysCell = daysCell as? CalendarDaysCell {
                daysCell.setupCell(date: "\(indexPath.row)")
            }
            return daysCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.weeks.count
        } else {
            return 35
        }
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizonalCount:CGFloat = 7
        let horizonalSpace:CGFloat = self.calendarCollection.frame.width / horizonalCount
        let weekVerticalSpace: CGFloat = 22
        if indexPath.section == 0 {
            return CGSize(width: horizonalSpace, height: weekVerticalSpace)
        } else {
            let verticalCount:CGFloat = 5
            let verticalSpace:CGFloat = (self.calendarCollection.frame.height - weekVerticalSpace) / verticalCount
            return CGSize(width: horizonalSpace, height: verticalSpace)
        }
    }
    // セル間のスペースについて
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
}
