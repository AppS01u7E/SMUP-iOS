import RxSwift
import Foundation

final class TimeTableRemote: BaseRemote<TimeTableAPI> {
    static let shared = TimeTableRemote()
    
    func getTimeTable() -> Single<TimeTable> {
        return request(.getTimeTable)
            .map(TimeTable.self)
    }
    
    func getTimeTableBetween(start: Date, end: Date) -> Single<[TimeTable]> {
        return request(.getTimeTableWithDate(start: start, end: end))
            .map([TimeTable].self)
    }
}
