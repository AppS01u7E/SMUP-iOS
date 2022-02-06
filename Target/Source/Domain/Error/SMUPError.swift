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
    
    
}

extension SMUPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "인터넷이 연결되어있지 않습니다."
        case .unauthorization:
            return "권한이 없습니다."
        }
    }
}
