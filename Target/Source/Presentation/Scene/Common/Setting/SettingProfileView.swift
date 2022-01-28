//
//  SettingProfileView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class SettingProfileView: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 44
        $0.clipsToBounds = true
    }
    private let usernameLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 18)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    private let schoolLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 16)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = UIScreen.main.bounds.width*0.0223
    }
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = SMUPAsset.smupMain3.color.withAlphaComponent(0.57)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.applyShadow(color: .black, radius: 2, offSet: .init(width: 2, height: 2), opacity: 0.1)
    }
    
    // MARK: - OpenMethod
    public func setUser(user: dummyUser){
        profileImageView.kf.setImage(with: URL(string: user.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        usernameLabel.text = user.username
        schoolLabel.text = user.school
    }
}

// MARK: - UI
private extension SettingProfileView{
    func addView(){
        stack.addArrangeSubviews(profileImageView, usernameLabel, schoolLabel)
        addSubViews(stack)
    }
    func setLayout(){
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(88)
        }
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(bound.height*0.039)
        }
    }
    func configureView(){
        
    }
}
