//
//  CheckScheduleButton.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then

final class CheckScheduleButton: UIButton {
    // MARK: - Properties
    private let chevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")?
            .tintColor(.white)
            .downSample(size: .init(width: 8, height: 8))
    }
    private let buttonTtitleLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.black, size: 24)
        $0.textColor = .white
    }
    
    private let bound = UIScreen.main.bounds
    
    // MARK: - Init
    init(title: String){
        super.init(frame: .zero)
        self.buttonTtitleLabel.text = title
        addView()
        setLayout()
    }
    
    override func layoutSubviews() {
        setGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OpenMethod
    public func setGradient(){
        self.applyGradient(
            colors: [
                SMUPAsset.smupMain2.color.withAlphaComponent(0.5).cgColor,
                SMUPAsset.smupMain2.color.cgColor
            ],
            locations: [
                0.0, 1.0
            ],
            startPoint: .init(x: 0, y: 1),
            endPoint: .init(x: 1, y: 1))
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
}

// MARK: - UI
private extension CheckScheduleButton{
    func addView(){
        addSubViews(chevronImage, buttonTtitleLabel)
    }
    func setLayout(){
        chevronImage.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(22)
        }
        buttonTtitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(14)
        }
    }
}
