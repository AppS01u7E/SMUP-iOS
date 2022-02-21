import RxFlow
import Foundation

final class GetTimeTableBetweenUseCase {
    @Inject private var repository: TimeTableRepository
    
    func execute(start: Date, end: Date) -> Single<[TimeTable]> {
        return repository.getTimeTableBetween(start: start, end: end)
    }
}
