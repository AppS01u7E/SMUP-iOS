import RxSwift
import Foundation

protocol TimeTableRepository{
    func getTimeTable() -> Single<TimeTable>
    func getTimeTableBetween(start: Date, end: Date) -> Single<[TimeTable]>
}
