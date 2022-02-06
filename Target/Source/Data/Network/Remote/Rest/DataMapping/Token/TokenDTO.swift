//
//  TokenResponse.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation

struct TokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
