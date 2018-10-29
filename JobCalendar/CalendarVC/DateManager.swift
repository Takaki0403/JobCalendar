
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
    
    func mkDaysInMonth(year: Int, month: Int) -> (daysInMonth: [Int], daysOfPreMonth: Int, daysOfLastMonth: Int) {
        var daysInMonth: [Int] = []
        let dayCountInMonth = self.getDaysInMonth(year: year, month: month)
        var dayCountInLastMonth: Int = 0
        if month == 1 {
            dayCountInLastMonth = self.getDaysInMonth(year: year, month: 12)
        } else {
            dayCountInLastMonth = self.getDaysInMonth(year: year, month: month - 1)
        }
        let firstWeekInMonth = self.getFirstWeekInMonth(year: year, month: month)
        for dayOfLastMonth in 0..<firstWeekInMonth {
            daysInMonth.append(dayCountInLastMonth - firstWeekInMonth + dayOfLastMonth + 1)
        }
        
        for day in 1...dayCountInMonth {
            daysInMonth.append(day)
        }
        var dayInNextMonth: Int = 1
        let daysOfLastMonth = daysInMonth.count
        while daysInMonth.count < 49 {
            daysInMonth.append(dayInNextMonth)
            dayInNextMonth += 1
        }
        return (daysInMonth, firstWeekInMonth, daysOfLastMonth)
    }
    
    func decideMonthAndYear(year: Int, month: Int) -> (year: Int, month: Int){
        var new_year: Int = 0
        var new_month: Int = 0
        if month > 12 {
            new_year = year + 1
            new_month = 1
        } else if month < 1 {
            new_year = year - 1
            new_month = 12
        } else {
            new_year = year
            new_month = month
        }
        
        return (new_year, new_month)
    }
    
    func getWeekCountInMonth(year: Int, month: Int) -> Int {
        var weekCountInMonth = 0
        let dayCountInMonth = self.getDaysInMonth(year: year, month: month)
        let firstWeekInMonth = self.getFirstWeekInMonth(year: year, month: month)
        print("firstWeekInMonth: \(firstWeekInMonth)")
        if (dayCountInMonth + firstWeekInMonth) <= 4 * 7 {
            weekCountInMonth = 4
        } else if (dayCountInMonth + firstWeekInMonth) > 5 * 7 {
            weekCountInMonth = 6
        } else {
            weekCountInMonth = 5
        }
        
        return weekCountInMonth
    }
}
