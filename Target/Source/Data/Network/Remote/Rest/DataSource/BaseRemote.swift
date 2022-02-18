//
//  BaseRemote.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/06.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BaseRemote<API: SMUPAPI> {
    // MARK: - Properties
    private let provider = MoyaProvider<API>(plugins: [JWTPlugin(), NetworkLoggerPlugin()])
    
    func request(_ api: API) -> Single<Response> {
        return Single.create { single in
            var dispose: [Disposable] = []
            if self.isAuthorizable(api) {
                dispose.append(
                    self.authorizableRequest(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            } else {
                dispose.append(
                    self.defaultRequest(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            }
            return Disposables.create(dispose)
        }
    }
}

private extension BaseRemote {
    func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .catch { err in
                guard let moyaError = err as? MoyaError else {
                    return .error(err)
                }
                return .error(api.errorMapper?[moyaError.errorCode] ?? err)
            }
    }
    
    func authorizableRequest(_ api: API) -> Single<Response> {
        return Single<Response>.create { single in
            var dispose: [Disposable] = []
            do {
                if try self.tokenIsExist() {
                    dispose.append(
                        self.defaultRequest(api).subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                    )
                } else {
                    single(.failure(TokenError.noToken))
                }
            } catch {
                single(.failure(TokenError.noToken))
            }
            return Disposables.create(dispose)
        }
        .retry(when: { (errorObservable: Observable<TokenError>) in
            errorObservable.flatMap { error -> Single<Void> in
                if error == .tokenExpired {
                    return AuthRemote.shared.reissue()
                }
                throw TokenError.noToken
            }
        })
    }
}

private extension BaseRemote {
    func isAuthorizable(_ api: API) -> Bool {
        return api.jwtTokenType != JWTTokenType.none
    }
    func tokenIsExist() throws -> Bool {
        do {
            let access = try Keychain.shared.load(type: .accessToken)
            return !access.isEmpty
        } catch {
            throw TokenError.noToken
        }
    }
}
