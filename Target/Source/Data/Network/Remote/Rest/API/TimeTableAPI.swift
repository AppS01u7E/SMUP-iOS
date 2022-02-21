import Moya
import Foundation

enum TimeTableAPI {
    case getTimeTable
    case getTimeTableWithDate(start: Date, end: Date)
}

extension TimeTableAPI: SMUPAPI {
    var domain: SMUPDomain {
        return .timeTable
    }
    var urlPath: String {
        switch self {
        case .getTimeTable:
            return ""
        case .getTimeTableWithDate:
            return "/between"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getTimeTable:
            return .requestPlain
        case let .getTimeTableWithDate(start, end):
            return .requestParameters(parameters: [
                "startDate": start.toString(.custom("yyyyMMdd")),
                "endDate": end.toString(.custom("yyyyMMdd"))
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
    
    var errorMapper: [Int : SMUPError]? {
        return [
            401: .unauthorization,
            403: .forbidden,
            404: .notFound
        ]
    }
}
