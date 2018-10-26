import UIKit

class CalendarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var calendarCollection: UICollectionView!
    let cellMargin: CGFloat = 0
    let daysCellHorizonalCount:CGFloat = 7
    let daysCellVerticalCount:CGFloat = 5
    let weekVerticalSpace: CGFloat = 22
    let presentYear = 2018
    let presentMonth = 10
    
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
            let dateManager = DateManager()
            let daysInMonth = dateManager.mkDaysInMonth(year: self.presentYear, month: self.presentMonth)
            let daysCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.days.rawValue, for: indexPath)
            if let daysCell = daysCell as? CalendarDaysCell {
                daysCell.dateLabel.text = String(daysInMonth[indexPath.row])
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
            return weeks.count
        } else {
            return Int(daysCellHorizonalCount * daysCellVerticalCount)
        }
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizonalSpace:CGFloat = self.calendarCollection.frame.width / daysCellHorizonalCount
        if indexPath.section == 0 {
            return CGSize(width: horizonalSpace, height: weekVerticalSpace)
        } else {
            let verticalSpace:CGFloat = (self.calendarCollection.frame.height - weekVerticalSpace) / daysCellVerticalCount
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
