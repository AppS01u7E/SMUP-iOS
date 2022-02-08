//
//  SettingProfileView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import FlexLayout
import PinLayout
import Kingfisher

final class SettingProfileView: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    private let rootContainer = UIView()
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 44
        $0.clipsToBounds = true
    }
    private let usernameLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 18)
        $0.textColor = SMUPAsset.smupGray1.color
        $0.textAlignment = .center
    }
    private let schoolLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 16)
        $0.textColor = SMUPAsset.smupGray1.color
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        rootContainer.pin.all()
        rootContainer.flex.layout()
        self.backgroundColor = SMUPAsset.smupMain3.color
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.applyShadow(color: SMUPAsset.smupGray7.color, radius: 2, offSet: .init(width: 2, height: 2), opacity: 0.1)
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
        addSubViews(rootContainer)
    }
    func setLayout(){
        rootContainer.flex.alignItems(.center).justifyContent(.center).define { flex in
            flex.addItem(profileImageView).size(88)
            flex.addItem(usernameLabel)
            flex.addItem(schoolLabel)
        }
    }
}
