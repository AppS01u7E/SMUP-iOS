//
//  AuthAPI.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Moya

enum AuthAPI {
    case login(LoginRequest)
    case signup(SignupRequest)
    case teacherSignup(TeacherSignupRequest)
    case reissue
}

extension AuthAPI: SMUPAPI {
    var domain: SMUPDomain {
        return .auth
    }
    var urlPath: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .teacherSignup:
            return "/signup/teacher"
        case .reissue:
            return "/refresh"
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return JWTTokenType.none
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
        case let .signup(req):
            return .requestJSONEncodable(req)
        case let .teacherSignup(req):
            return .requestJSONEncodable(req)
        case .reissue:
            return .requestPlain
            
        }
    }
    
    var errorMapper: [Int : SMUPError]? {
        return [
            401: .unauthorization,
            403: .forbidden,
            404: .notFound
        ]
    }
    
}
