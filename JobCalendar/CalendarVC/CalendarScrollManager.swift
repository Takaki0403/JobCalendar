//import UIKit
//
//class CalendarScrollManager: NSObject {
//    func showNextView (){
//        currentMonth++;
//        if( currentMonth > 12 ){
//            currentMonth = 1;
//            currentYear++;
//        }
//        var tmpView:MonthView = currentMonthView
//        currentMonthView = nextMonthView
//        nextMonthView    = prevMonthView
//        prevMonthView    = tmpView
//        
//        var ret = self.getNextYearAndMonth()
//        nextMonthView.setUpDays(ret.year, month:ret.month)
//        
//        self.resetContentOffSet()
//        
//    }
//    
//    func showPrevView () {
//        currentMonth--
//        if( currentMonth == 0 ){
//            currentMonth = 12
//            currentYear--
//        }
//        
//        var tmpView:MonthView = currentMonthView
//        currentMonthView = prevMonthView
//        prevMonthView    = nextMonthView
//        nextMonthView    = tmpView
//        var ret = self.getPrevYearAndMonth()
//        prevMonthView.setUpDays(ret.year, month:ret.month)
//        
//        //position調整
//        self.resetContentOffSet()
//    }
//    
//    
//    func resetContentOffSet () {
//        //position調整
//        prevMonthView.frame = CGRectMake(0, 0, frame.size.width,frame.size.height)
//        currentMonthView.frame = CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height)
//        nextMonthView.frame = CGRectMake(frame.size.width * 2.0, 0, frame.size.width,frame.size.height)
//        
//        var scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
//        scrollView.delegate = nil
//        //delegateを呼びたくないので
//        scrollView.contentOffset = CGPointMake(frame.size.width , 0.0);
//        scrollView.delegate = scrollViewDelegate
//        
//    }
//    
//    func getNextYearAndMonth () -> (year:Int,month:Int){
//        var next_year:Int = currentYear
//        var next_month:Int = currentMonth + 1
//        if next_month > 12 {
//            next_month=1
//            next_year++
//        }
//        return (next_year,next_month)
//    }
//    func getPrevYearAndMonth () -> (year:Int,month:Int){
//        var prev_year:Int = currentYear
//        var prev_month:Int = currentMonth - 1
//        if prev_month == 0 {
//            prev_month = 12
//            prev_year--
//        }
//        return (prev_year,prev_month)
//    }
//}
