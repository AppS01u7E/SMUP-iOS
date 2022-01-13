//
//  SignInVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import AuthenticationServices
import RxCocoa
import RxSwift

final class SignInVC: baseVC<SignInReactor>{
    // MARK: - Properties
    private let logoLabel = UILabel().then {
        $0.text = "SMUP"
        $0.textColor = .white
        $0.font = UIFont(font: SMUPFontFamily.NotoSansKR.black, size: 72)
    }
    
    private let appleSignInButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(logoLabel, appleSignInButton)
    }
    override func setLayout() {
        logoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        appleSignInButton.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(bound.height*0.123)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.159)
            $0.height.equalTo(44)
        }
    }
    override func configureVC() {
        view.backgroundColor = SMUPAsset.smupMain3.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SignInReactor) {
        appleSignInButton.rx.controlEvent(.touchUpInside)
            .map { _ in Reactor.Action.appleSignInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
