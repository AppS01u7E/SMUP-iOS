//
//  SMUPError.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation

// MARK: - SMUPError
enum SMUPError: Error {
    // MARK: Base
    case noInternet
    case unauthorization
    
    // MARK: signin
    case wrongRefreshToken
    
    // MARK: group
    case notFound
    case pagenationPolicyViolation
    case groupTypePolicyViolation
    case permisionDenid
    case idPolicyViolation
    case alreadyJoined
}

extension SMUPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "인터넷이 연결되어있지 않습니다."
        case .unauthorization:
            return "권한이 없습니다."
        case .wrongRefreshToken:
            return "refresh토큰이 잘못되었습니다."
        case .notFound:
            return "request에 해당하는 것을 찾지 못하였습니다."
        case .pagenationPolicyViolation:
            return "idx나 size가 자연수가 아닙니다."
        case .groupTypePolicyViolation:
            return "Group Type이 정책을 위반합니다."
        case .permisionDenid:
            return "해당 그룹의 type을 수정할 권한이 없습니다."
        case .idPolicyViolation:
            return "ID가 자연수가 아닙니다."
        case .alreadyJoined:
            return "이미 그룹에 가입되어있습니다."
        }
    }
}
