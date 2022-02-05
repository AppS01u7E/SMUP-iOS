//
//  ScheduleView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class ScheduleView: UIView{
    // MARK: - Properties
    private let rootContainer = UIView()
    private let perioLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 16)
        $0.textColor = SMUPAsset.smupGray7.color
    }
    private let contentLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 14)
        $0.textColor = SMUPAsset.smupGray7.color
    }
    private let referenceLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = SMUPAsset.smupGray7.color
    }
    
    override func layoutSubviews() {
        rootContainer.pin.all()
        rootContainer.flex.layout()
        
        rootContainer.layer.cornerRadius = 10
        rootContainer.clipsToBounds = true
        rootContainer.backgroundColor = SMUPAsset.smupGray1.color
        self.layer.masksToBounds = false
        self.layer.borderWidth = 0
        self.applyShadow(color: SMUPAsset.smupGray7.color, radius: 2.5, offSet: .init(width: 0, height: 3), opacity: 0.5)
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
    
    // MARK: - OpneMethod
    public func bind(_ model: Schedule){
        perioLabel.text = "\(model.perio)교시 \(model.name)"
        let conStr = NSMutableAttributedString()
        model.content.forEach{ con in
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "circle.fill")?.tintColor(.systemGray3).downSample(size: .init(width: 3, height: 3))
            conStr.append(.init(string: "\t"))
            conStr.append(.init(attachment: imageAttachment))
            conStr.append(.init(string: " \(con)\n"))
        }
        contentLabel.attributedText = conStr
        referenceLabel.text = model.reference
    }
}

// MARK: - UI
private extension ScheduleView{
    func addView(){
        addSubViews(rootContainer)
    }
    func setLayout(){
        rootContainer.flex.padding(10).define { flex in
            flex.addItem(perioLabel)
            flex.addItem(contentLabel).paddingTop(7)
            flex.addItem(referenceLabel).paddingTop(7)
        }
    }
}
