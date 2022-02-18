//
//  SigninAPI.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Moya

enum SigninAPI {
    
    case reissue
}

extension SigninAPI: SMUPAPI {
    var domain: SMUPDomain {
        return .signin
    }
    
    var urlPath: String {
        switch self {
        case .reissue:
            return "/reissue"
        }
    }
    
    var method: Method {
        switch self {
        case .reissue:
            return .get
        }
    }
    
    
    var task: Task {
        switch self {
        case .reissue:
            return reissue()
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
            
        default:
            return JWTTokenType.none
        }
    }
    
    var errorMapper: [Int : SMUPError]? {
        switch self {
        case .reissue:
            return [
                :
            ]
        }
    }
}
