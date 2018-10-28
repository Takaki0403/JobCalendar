import UIKit

class CalendarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var headerV: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var calendarCollection: UICollectionView!
    
    let cellMargin: CGFloat = 0.4
    let daysCellHorizonalCount:CGFloat = 7
    let daysCellVerticalCount:CGFloat = 5
    let weekVerticalSize: CGFloat = 22
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollection.register(UINib(nibName: CalendarCellName.days.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.days.rawValue)
        calendarCollection.register(UINib(nibName: CalendarCellName.week.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.week.rawValue)
        
        self.cal.locale = Locale(identifier: "ja")
        self.dateFormatter.locale = Locale(identifier: "ja_JP")
        self.dateFormatter.dateFormat = "yyyy年M月"
        self.components.year = self.cal.component(.year, from: now)
        self.components.month = self.cal.component(.month, from: now)
        self.components.day = 1
        self.updateHeaderTitleLabel(components: self.components)
    }
    
    func updateHeaderTitleLabel(components: DateComponents) {
        let firstDayOfMonth = self.cal.date(from: components)
        self.headerTitleLabel.text = self.dateFormatter.string(from: firstDayOfMonth!)
    }
    
    @IBAction func headerLeftBtn(_ sender: Any) {
        self.components.month = self.components.month! - 1
        if self.components.month! < 1 {
            self.components.month = 12
            self.components.year = self.components.year! - 1
        }
        updateHeaderTitleLabel(components: self.components)
        calendarCollection.reloadData()
    }
    
    @IBAction func headerRightBtn(_ sender: Any) {
        self.components.month = self.components.month! + 1
        if self.components.month! > 12 {
            self.components.month = 1
            self.components.year = self.components.year! + 1
        }
        updateHeaderTitleLabel(components: self.components)
        calendarCollection.reloadData()
    }
    
}

extension CalendarVC {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let dateManager = DateManager()
        let calendarContents = dateManager.mkDaysInMonth(year: self.components.year!, month: self.components.month!)
        if indexPath.section == 0 {
            let weekCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.week.rawValue, for: indexPath)
            if let weekCell = weekCell as? CalendarWeekCell {
                weekCell.setupCell(week: weeks[indexPath.row], indexPath: indexPath, daysOfPreMonth: calendarContents.daysOfPreMonth, daysOfLastMonth: calendarContents.daysOfLastMonth)
            }
            return weekCell
        } else {
            let daysCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.days.rawValue, for: indexPath)
            if let daysCell = daysCell as? CalendarDaysCell {
                daysCell.setupCell(date: String(calendarContents.daysInMonth[indexPath.row]), indexPath: indexPath, daysOfPreMonth: calendarContents.daysOfPreMonth, daysOfLastMonth: calendarContents.daysOfLastMonth)
            }
            return daysCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizonalSize:CGFloat = (self.calendarCollection.frame.width - self.cellMargin * (self.daysCellHorizonalCount - 1)) / self.daysCellHorizonalCount
        if indexPath.section == 0 {
            return CGSize(width: horizonalSize.rounded(.down), height: self.weekVerticalSize)
        } else {
            let verticalSize:CGFloat = (self.calendarCollection.frame.height - self.weekVerticalSize - self.cellMargin * self.daysCellVerticalCount) / self.daysCellVerticalCount
            return CGSize(width: horizonalSize.rounded(.down), height: verticalSize.rounded(.down))
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
