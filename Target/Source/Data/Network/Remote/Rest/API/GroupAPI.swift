import Moya
import Foundation

enum GroupAPI {
    case getGroupListWithTitle(String)
    case getGroupListWithID(UUID)
    case getGroupList(GroupListLookUpRequest)
    
    
}

extension GroupAPI: SMUPAPI {
    var domain: SMUPDomain {
        return .group
    }
    
    var urlPath: String {
        switch self {
        case let .getGroupListWithTitle(title):
            return "/title/\(title)"
        case let .getGroupListWithID(id):
            return "/title/\(id)"
        case .getGroupList:
            return "/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID, .getGroupList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID:
            return .requestPlain
        case let .getGroupList(req):
            return .requestParameters(parameters: [
                "idx" : req.idx,
                "size" : req.size,
                "type" : req.type.rawValue
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
            
        default:
            return .accessToken
        }
    }
    
    var errorMapper: [Int : SMUPError]? {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID:
            return [
                404: .groupNotFound,
                403: .unauthorization
            ]
        case .getGroupList:
            return [
                400: .pagenationPolicyViolation,
                404: .groupNotFound,
                403: .unauthorization
            ]
        }
    }
}
