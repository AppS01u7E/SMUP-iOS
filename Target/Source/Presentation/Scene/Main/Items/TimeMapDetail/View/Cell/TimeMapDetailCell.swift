//
//  TimeMapDetailCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

protocol TimeMapDetailCellDelegate: AnyObject{
    func goDirectButtonDidTap()
}
final class TimeMapDetailCell: baseCollectionViewCell<TimeMap>{
    // MARK: - Properties
    private let dateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 20)
    }
    private let perioLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 19)
    }
    private let dateStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let contentLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 17)
    }
    
    private let referenceLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 12)
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    private let goDirectButton = UIButton().then {
        $0.setTitle("보러 가기", for: .normal)
        $0.setTitleColor(SMUPAsset.smupMain2.color, for: .normal)
        $0.setImage(.init(systemName: "chevron.right.circle")?.tintColor(SMUPAsset.smupMain2.color).downSample(size: .init(width: 14, height: 14))
                    , for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    weak var delegate: TimeMapDetailCellDelegate?
    
    // MARK: - UI
    override func addView() {
        dateStack.addArrangeSubviews(dateLabel, perioLabel)
        addSubViews(scrollView, goDirectButton)
        scrollView.addSubViews(dateStack, contentLabel, referenceLabel)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dateStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(bound.height*0.05)
        }
        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateStack.snp.bottom).offset(bound.height*0.02)
            $0.leading.trailing.equalToSuperview().inset(3)
        }
        referenceLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(bound.height*0.02)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.07)
        }
        goDirectButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(10)
        }
        
    }
    override func configureCell() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        goDirectButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { `self`, _ in
                `self`.delegate?.goDirectButtonDidTap()
            })
            .disposed(by: disposeBag)
    }
    override func bind(_ model: TimeMap) {
        dateLabel.text = model.date.toString(.custom("yyyy년 MM월 dd일"))
        perioLabel.text = "\(model.perio.convertPerio()) \(model.name)"
        let conStr = NSMutableAttributedString()
        model.content.forEach{ con in
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "circle.fill")?.tintColor(.systemGray3).downSample(size: .init(width: 5, height: 5))
            conStr.append(.init(string: "\t\t"))
            conStr.append(.init(attachment: imageAttachment))
            conStr.append(.init(string: " \(con)\n"))
        }
        contentLabel.attributedText = conStr
        referenceLabel.text = model.reference
    }
    
}
