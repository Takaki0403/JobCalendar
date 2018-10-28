import RealmSwift

class RealmAction: NSObject {
    func addCalendarContentsToRealm(contents: CalendarContentsStruct) {
        let realm = try! Realm()
        var objectId = 0
        if contents.id == nil {
            objectId = realm.objects(CalendarContentsSheet.self).count
        } else {
            objectId = contents.id!
        }
        let newObject = CalendarContentsSheet()
        newObject.id = objectId
        newObject.date = contents.date
        newObject.year = contents.year
        newObject.month = contents.month
        newObject.day = contents.day
        newObject.job_type = contents.job_type
        newObject.memo = contents.memo
        RealmManager.addObject(object: newObject, update: true)
    }
}