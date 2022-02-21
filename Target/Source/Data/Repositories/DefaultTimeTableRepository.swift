import RxSwift

final class DefaultTimeTableRepository: TimeTableRepository {
    func getTimeTable() -> Single<TimeTable> {
        return TimeTableRemote.shared.getTimeTable()
    }
    
    func getTimeTableBetween(start: Date, end: Date) -> Single<[TimeTable]> {
        return TimeTableRemote.shared.getTimeTableBetween(start: start, end: end)
    }
}
