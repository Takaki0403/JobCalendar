import RealmSwift
import UIKit

class CalendarContentsSheet: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Date?
    @objc dynamic var year: Int = 0
    @objc dynamic var month: Int = 0
    @objc dynamic var day: Int = 0
    @objc dynamic var job_type: String?
    @objc dynamic var memo: String?
    @objc dynamic var created: Date = Date()
    @objc dynamic var update_at: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
