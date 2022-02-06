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
    
    // MARK: 그룹 삭제 투표
    case deleteGroup(id: Int)
    case getDeleteRequester(id: Int)
    
    // MARK: 그룹 인원 관리
    case getGroupJoinList(groupID: String)
    case getGroupIsRequested(groupID: String)
    case postRequestJoinGroup(groupID: String)
    case putAcceptJoin(groupID: String, userID: String)
    case putAcceptJoinAll(groupID: String)
    case deleteRejectJoin(groupID: String, userID: String)
    case deleteRejectAll(groupID: String)
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
        case let .deleteGroup(id):
            return "/\(id)"
        case let .getDeleteRequester(id):
            return "/\(id)"
        case let .getGroupJoinList(groupID):
            return "/\(groupID)/join/list"
        case let .getGroupIsRequested(groupID):
            return "/\(groupID)/join"
        case let .postRequestJoinGroup(groupID):
            return "/\(groupID)/join"
        case let .putAcceptJoin(groupID, userID):
            return "/\(groupID)/join/\(userID)"
        case let .putAcceptJoinAll(groupID):
            return "/\(groupID)/join/all"
        case let .deleteRejectJoin(groupID, userID):
            return "/\(groupID)/join/\(userID)"
        case let .deleteRejectAll(groupID):
            return "/\(groupID)/join/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGroupListWithTitle, .getGroupListWithID, .getGroupList, .getDeleteRequester,
                .getGroupJoinList, .getGroupIsRequested:
            return .get
        case .postCreateGroup, .postRequestJoinGroup:
            return .post
        case .putAcceptJoin, .putAcceptJoinAll:
            return .put
        case .patchUpdateGroup, .patchGroupProfile:
            return .patch
        case .deleteGroup, .deleteRejectJoin, .deleteRejectAll:
            return .delete
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
        default:
            return .requestPlain
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
                404: .notFound,
                403: .unauthorization
            ]
        case .getGroupList:
            return [
                400: .pagenationPolicyViolation,
                404: .notFound,
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
                404: .notFound
            ]
        case .patchGroupProfile:
            return [
                403: .permisionDenid,
                
            ]
        case .deleteGroup:
            return [
                400: .idPolicyViolation,
                403: .permisionDenid,
                404: .notFound
            ]
        case .getDeleteRequester:
            return [
                400: .idPolicyViolation,
                403: .permisionDenid,
                404: .notFound
            ]
        case .getGroupJoinList:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        case .getGroupIsRequested:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        case .postRequestJoinGroup:
            return [
                400: .alreadyJoined,
                404: .notFound
            ]
        case .putAcceptJoin:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        case .putAcceptJoinAll:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        case .deleteRejectJoin:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        case .deleteRejectAll:
            return [
                403: .permisionDenid,
                404: .notFound
            ]
        }
    }
}
