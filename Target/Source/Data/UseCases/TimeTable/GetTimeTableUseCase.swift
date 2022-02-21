import RxSwift

final class GetTimeTableUseCase {
    @Inject private var repository: TimeTableRepository
    
    func execute() -> Single<TimeTable> {
        return repository.getTimeTable()
    }
}
