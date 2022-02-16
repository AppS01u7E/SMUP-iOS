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
    case forbidden
    case notFound
}

extension SMUPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "인터넷이 연결되어있지 않습니다."
        case .unauthorization:
            return "권한이 없습니다."
        case .forbidden:
            return "활성화된 accessToken을 찾을 수 없습니다."
        case .notFound:
            return "결과를 찾지 못하였습니다."
        }
    }
}
