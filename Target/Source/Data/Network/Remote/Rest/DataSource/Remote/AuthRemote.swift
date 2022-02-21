//
//  AuthRemote.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    
    func login(req: LoginRequest) -> Single<Void> {
        return request(.login(req))
            .map(TokenDTO.self)
            .do(onSuccess: { token in
                Keychain.shared.save(type: .accessToken, value: token.accessToken)
                Keychain.shared.save(type: .refreshToken, value: token.refreshToken)
            })
            .map { _ in () }
    }
    func signup(req: SignupRequest) -> Single<Void> {
        return request(.signup(req))
            .map { _ in () }
    }
    func teacherSignup(req: TeacherSignupRequest) -> Single<Void> {
        return request(.teacherSignup(req))
            .map { _ in () }
    }
    func reissue() -> Single<Void> {
        return request(.reissue)
            .map(TokenDTO.self)
            .do(onSuccess: { token in
                Keychain.shared.save(type: .accessToken, value: token.accessToken)
                Keychain.shared.save(type: .refreshToken, value: token.refreshToken)
            })
            .map { _ in () }
    }
}
