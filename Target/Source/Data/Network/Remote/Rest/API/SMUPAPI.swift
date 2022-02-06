//
//  SMUPAPI.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import Moya

protocol SMUPAPI: TargetType, JWTTokenAuthorizable {
    var domain: SMUPDomain { get }
    var urlPath: String { get }
    var errorMapper: [Int: SMUPError]? { get }
}

extension SMUPAPI {
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        return domain.url + urlPath
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String : String]? {
        switch self {
        
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

enum SMUPDomain: String {
    case auth
    case signup
    case signin
    case account
}

extension SMUPDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}
