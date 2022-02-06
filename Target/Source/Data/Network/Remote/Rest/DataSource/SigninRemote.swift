//
//  SigninRemote.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift

final class SigninRemote: BaseRemote<SigninAPI> {
    static let shared = SigninRemote()
    
    
    func reissueToken() -> Single<Void>{
        return request(.reissue)
            .map { _ in Void() }
    }
}
