//
//  JWTPlugin.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import Moya

protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

enum JWTTokenType {
    case none

    case accessToken
    case refreshToken

    public var headerString: String {
        switch self {
        case .accessToken:
            return "Authorization1"
        default:
            return ""
        }
    }
}

final class JWTPlugin: PluginType {
    
    func prepare(
        _ request: URLRequest,
        target: TargetType
    ) throws -> URLRequest {
        guard let authorizable = target as? JWTTokenAuthorizable,
              let tokenType = authorizable.jwtTokenType,
              tokenType != .none
        else { return request }
        
        var request = request
        
        let token = getToken(type: tokenType)
        request.addValue(token, forHTTPHeaderField: tokenType.headerString)
        return request
    }
    
    func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        switch result {
        case let .success(res):
            if let newToken = try? res.map(TokenDTO.self) {
                self.setToken(token: newToken)
            }
        default:
            break
        }
    }
}

private extension JWTPlugin {
    func getToken(type: JWTTokenType) -> String {
        switch type {
        case .accessToken:
            return getAccessToken()
        case .refreshToken:
            return getRefreshToken()
        case .none:
            return ""
        }
    }
    
    func getAccessToken() -> String {
        do {
            return try Keychain.shared.load(type: .accessToken)
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func getRefreshToken() -> String {
        do {
            return try Keychain.shared.load(type: .refreshToken)
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func setToken(token: TokenDTO) {
        Keychain.shared.save(type: .accessToken, value: token.accessToken)
        Keychain.shared.save(type: .refreshToken, value: token.refreshToken)
    }
}
