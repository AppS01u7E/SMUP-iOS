//
//  Keychain.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Security
import Foundation

enum KeychainType: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
}

enum KeychainError: Error {
    case noData
}

final class Keychain {
    static let shared = Keychain()
    
    private let service = Bundle.main.bundleIdentifier ?? ""
    
    func save(type: KeychainType, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init()
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    func load(type: KeychainType) throws -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataRef)
        if status == errSecSuccess {
            guard let data = dataRef as? Data else { throw KeychainError.noData }
            let value = String(data: data, encoding: .utf8) ?? .init()
            return value
        } else {
            throw KeychainError.noData
        }
    }
    
    func delete(type: KeychainType) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue
        ]
        SecItemDelete(query)
    }
}
