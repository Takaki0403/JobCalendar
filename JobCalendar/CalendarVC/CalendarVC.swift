import UIKit

class CalendarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, AddTaskVManager {
    
    @IBOutlet weak var headerV: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var calendarCollection: UICollectionView!
    @IBOutlet weak var nextCalendarCollection: UICollectionView!
    @IBOutlet weak var lastCalendarCollection: UICollectionView!
    @IBOutlet weak var calendarScrollV: UIScrollView!
    @IBOutlet weak var scrollContentV: UIView!
    
    let cellMargin: CGFloat = 0.4
    let daysCellHorizonalCount:CGFloat = 7
    var daysCellVerticalCount:CGFloat = 0
    let weekVerticalSize: CGFloat = 22
    
    let dateManager = DateManager()
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var lastSelectedCellIndex: IndexPath = IndexPath(row: 0, section: 1)
    var calendarContents: (daysInMonth: [Int], daysOfLastMonth: Int, daysOfNextMonth: Int) = ([], 0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarCollection.register(UINib(nibName: CalendarCellName.days.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.days.rawValue)
        self.calendarCollection.register(UINib(nibName: CalendarCellName.week.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.week.rawValue)
        self.nextCalendarCollection.register(UINib(nibName: CalendarCellName.days.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.days.rawValue)
        self.nextCalendarCollection.register(UINib(nibName: CalendarCellName.week.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.week.rawValue)
        self.lastCalendarCollection.register(UINib(nibName: CalendarCellName.days.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.days.rawValue)
        self.lastCalendarCollection.register(UINib(nibName: CalendarCellName.week.rawValue, bundle: nil), forCellWithReuseIdentifier: CalendarCellName.week.rawValue)
        
        self.cal.locale = Locale(identifier: "ja")
        self.dateFormatter.locale = Locale(identifier: "ja_JP")
        self.dateFormatter.dateFormat = "yyyy年M月"
        self.components.year = self.cal.component(.year, from: now)
        self.components.month = self.cal.component(.month, from: now)
        self.components.day = 1
        self.updateHeaderTitleLabel(components: self.components)
        
        self.calendarCollection.frame.size = CGSize(width: self.calendarScrollV.frame.width, height: self.calendarScrollV.frame.height)
        self.calendarCollection.frame.origin = CGPoint(x: self.calendarCollection.frame.width, y: 0)
        self.nextCalendarCollection.frame.size = self.calendarCollection.frame.size
        self.lastCalendarCollection.frame.size = self.calendarCollection.frame.size
        self.nextCalendarCollection.frame.origin = CGPoint(x: self.calendarCollection.frame.width * 2, y: 0)
        self.lastCalendarCollection.frame.origin = CGPoint(x: 0, y: 0)
        
        self.calendarScrollV.contentSize = CGSize(width:self.calendarCollection.frame.width * 3, height:self.calendarCollection.frame.height)
        self.scrollContentV.frame = CGRect(x: 0, y: 0, width:self.calendarCollection.frame.width * 3, height:self.calendarCollection.frame.height)
        self.calendarScrollV.delegate = self
        self.calendarScrollV.contentOffset = CGPoint(x: self.calendarCollection.frame.width, y: 0)
    }
    
    func updateHeaderTitleLabel(components: DateComponents) {
        let firstDayOfMonth = self.cal.date(from: components)
        self.headerTitleLabel.text = self.dateFormatter.string(from: firstDayOfMonth!)

    }
    
    @IBAction func headerLeftBtn(_ sender: Any) {
        self.components.month = self.components.month! - 1
        let newYearAndMonth = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
        self.components.year = newYearAndMonth.year
        self.components.month = newYearAndMonth.month
        updateHeaderTitleLabel(components: self.components)
        self.calendarCollection.reloadData()
        self.nextCalendarCollection.reloadData()
        self.lastCalendarCollection.reloadData()
    }
    
    @IBAction func headerRightBtn(_ sender: Any) {
        self.components.month = self.components.month! + 1
        let newYearAndMonth = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
        self.components.year = newYearAndMonth.year
        self.components.month = newYearAndMonth.month
        updateHeaderTitleLabel(components: self.components)
        self.calendarCollection.reloadData()
        self.nextCalendarCollection.reloadData()
        self.lastCalendarCollection.reloadData()
    }
    
}

extension CalendarVC {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        if indexPath.section == 0 {
            let weekCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.week.rawValue, for: indexPath)
            if let weekCell = weekCell as? CalendarWeekCell {
                weekCell.setupCell(week: weeks[indexPath.row], indexPath: indexPath)
            }
            return weekCell
        } else {
            var month = self.components.month
            switch collectionView {
            case self.lastCalendarCollection:
                month = self.components.month! - 1
            case self.nextCalendarCollection:
                month = self.components.month! + 1
            case self.calendarCollection:
                month = self.components.month!
            default:
                break
            }
            let yearAndMonth = self.dateManager.decideMonthAndYear(year: self.components.year!, month: month!)
            calendarContents = self.dateManager.mkDaysInMonth(year: yearAndMonth.year, month: yearAndMonth.month)
            let daysCell:UICollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCellName.days.rawValue, for: indexPath)
            if let daysCell = daysCell as? CalendarDaysCell {
                daysCell.setupCell(year: yearAndMonth.year, month: yearAndMonth.month, date: String(calendarContents.daysInMonth[indexPath.row]), indexPath: indexPath, daysOfNextMonth: calendarContents.daysOfNextMonth, daysOfLastMonth: calendarContents.daysOfLastMonth)
                daysCell.backV.backgroundColor = UIColor.white
            }
            return daysCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.lastCalendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month! - 1))
        case self.calendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month!))
        case self.nextCalendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month! + 1))
        default:
            break
        }
        if section == 0 {
            return weeks.count
        } else {
            return Int(daysCellHorizonalCount * daysCellVerticalCount)
        }
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.lastCalendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month! - 1))
        case self.calendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month!))
        case self.nextCalendarCollection:
            self.daysCellVerticalCount = CGFloat(dateManager.getWeekCountInMonth(year: components.year!, month: components.month! + 1))
        default:
            break
        }
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
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row >= self.calendarContents.daysOfNextMonth && indexPath.row < self.calendarContents.daysOfLastMonth {
            let lastDateCell = collectionView.cellForItem(at: self.lastSelectedCellIndex) as! CalendarDaysCell
            lastDateCell.backV.backgroundColor = UIColor.white
            let dateCell = collectionView.cellForItem(at: indexPath) as! CalendarDaysCell
            dateCell.backV.backgroundColor = UIColor.orange
            self.lastSelectedCellIndex = indexPath

        }
    }
}

extension CalendarVC {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > self.calendarCollection.frame.width * 2 {
            let index = Int((scrollView.contentOffset.x / scrollView.frame.width).rounded())
            let fixX = CGFloat(index) * scrollView.frame.width
            self.calendarScrollV.setContentOffset(CGPoint(x:fixX, y:0), animated: false)
            let pos:CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
            let deff:CGFloat = pos - 1.0
            if abs(deff) >= 1.0 {
                if (deff > 0) {
                    self.components.month = self.components.month! + 1
                    let monthAndYear = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
                    self.components.year = monthAndYear.year
                    self.components.month = monthAndYear.month
                    self.lastCalendarCollection.reloadData()
                    self.calendarCollection.reloadData()
                    self.nextCalendarCollection.reloadData()
                    self.updateHeaderTitleLabel(components: self.components)
                } else {
                    self.components.month = self.components.month! - 1
                    let monthAndYear = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
                    self.components.year = monthAndYear.year
                    self.components.month = monthAndYear.month
                    self.lastCalendarCollection.reloadData()
                    self.calendarCollection.reloadData()
                    self.nextCalendarCollection.reloadData()
                    self.updateHeaderTitleLabel(components: self.components)
                }
            }
            resetContentOffSet()
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= self.calendarCollection.frame.width * 2 {
            let index = Int((scrollView.contentOffset.x / scrollView.frame.width).rounded())
            let fixX = CGFloat(index) * scrollView.frame.width
            self.calendarScrollV.setContentOffset(CGPoint(x:fixX, y:0), animated: false)
            let pos:CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
            let deff:CGFloat = pos - 1.0
            if abs(deff) >= 1.0 {
                if (deff > 0) {
                    self.components.month = self.components.month! + 1
                    let monthAndYear = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
                    self.components.year = monthAndYear.year
                    self.components.month = monthAndYear.month
                    self.lastCalendarCollection.reloadData()
                    self.calendarCollection.reloadData()
                    self.nextCalendarCollection.reloadData()
                    self.updateHeaderTitleLabel(components: self.components)
                } else {
                    self.components.month = self.components.month! - 1
                    let monthAndYear = dateManager.decideMonthAndYear(year: self.components.year!, month: self.components.month!)
                    self.components.year = monthAndYear.year
                    self.components.month = monthAndYear.month
                    self.lastCalendarCollection.reloadData()
                    self.calendarCollection.reloadData()
                    self.nextCalendarCollection.reloadData()
                    self.updateHeaderTitleLabel(components: self.components)
                }
            }
            resetContentOffSet()
        }
    }
    
    func resetContentOffSet () {
        let scrollViewDelegate:UIScrollViewDelegate = calendarScrollV.delegate!
        calendarScrollV.delegate = nil
        calendarScrollV.contentOffset = CGPoint(x: calendarScrollV.frame.size.width , y: 0.0);
        calendarScrollV.delegate = scrollViewDelegate
    }
}
