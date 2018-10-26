
import UIKit

class DateManager: NSObject {
    func getDaysInMonth(year: Int, month: Int) -> Int{
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        // 日数を求めたい次の月。13になってもOK。ドキュメントにも、月もしくは月数とある
        components.month = month + 1
        // 日数を0にすることで、前の月の最後の日になる
        components.day = 0
        // 求めたい月の最後の日のDateオブジェクトを得る
        let date = calendar.date(from: components)!
        let dayCount = calendar.component(.day, from: date)
        return dayCount
    }
    
    func getFirstWeekInMonth(year: Int, month: Int) -> Int {
        let selectedDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1))
        let firstWeek = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: selectedDate!)
        return firstWeek! - 1
    }
    
    func mkDaysInMonth(year: Int, month: Int) -> [Int] {
        var daysInMonth: [Int] = []
        let dayCountInMonth = self.getDaysInMonth(year: year, month: month)
        var dayCountInLastMonth: Int = 0
        if month == 1 {
            dayCountInLastMonth = self.getDaysInMonth(year: year, month: 12)
        } else {
            dayCountInLastMonth = self.getDaysInMonth(year: year, month: month - 1)
        }
        let firstWeekInMonth = self.getFirstWeekInMonth(year: year, month: month)
        for dayOfLastMonth in 1...firstWeekInMonth {
            daysInMonth.append(dayCountInLastMonth - firstWeekInMonth + dayOfLastMonth)
        }
        
        for day in 1...dayCountInMonth {
            daysInMonth.append(day)
        }
        var dayInNextMonth: Int = 1
        while daysInMonth.count < 35 {
            daysInMonth.append(dayInNextMonth)
            dayInNextMonth += 1
        }
        return daysInMonth
    }
}
