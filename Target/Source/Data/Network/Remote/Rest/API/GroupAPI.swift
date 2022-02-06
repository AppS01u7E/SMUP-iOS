import Moya
import Foundation

enum GroupAPI {
    // MARK: 그룹 조회
    case getGroupListWithTitle(String)
    case getGroupListWithID(UUID)
    case getGroupList(GroupListLookUpRequest)
    
    // MARK: 그룹 개설/수정
    case postCreateGroup(CreateGroupRequest)
    case patchUpdateGroup(UpdateGroupRequest)
    case patchGroupProfile(GroupProfileRequest)
    
    
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
        case .postCreateGroup:
            return ""
        case let .patchUpdateGroup(req):
            return "/\(req.id)"
        case let .patchGroupProfile(req):
            return "/\(req.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID, .getGroupList:
            return .get
        case .postCreateGroup:
            return .post
        case .patchUpdateGroup, .patchGroupProfile:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID:
            return .requestPlain
        case let .getGroupList(req):
            return .requestParameters(parameters: [
                "idx": req.idx,
                "size": req.size,
                "type": req.type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .postCreateGroup(req):
            return .requestJSONEncodable(req)
        case let .patchUpdateGroup(req):
            return .requestParameters(parameters: [
                "name": req.name,
                "description": req.description,
                "type" : req.type.rawValue
            ], encoding: JSONEncoding.default)
        case let .patchGroupProfile(req):
            let form = [MultipartFormData(provider: .data(req.image.pngData() ?? .init()),
                                         name: "img")]
            return .uploadMultipart(form)
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
        case .postCreateGroup:
            return [
                
                403: .unauthorization
            ]
        case .patchUpdateGroup:
            return [
                400: .groupTypePolicyViolation,
                403: .permisionDenid,
                404: .groupNotFound
            ]
        case .patchGroupProfile:
            return [
                403: .permisionDenid,
                
            ]
        }
    }
}
