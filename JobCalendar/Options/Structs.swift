import UIKit

// For used Realm: CalendarContentsSheet
struct  CalendarContentsStruct {
    var id: Int? = nil // When NewObjects added, this is nil
    var date: Date?
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var job_type: String?
    var memo: String?
}
