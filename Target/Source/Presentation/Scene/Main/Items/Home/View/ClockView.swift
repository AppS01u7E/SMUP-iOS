//
//  ClockView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/22.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import KDCircularProgress
import Then

final class ClockView: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    private let rootContainer = UIView()
    private let hourImageView = UIImageView()
    private let circularView = KDCircularProgress().then {
        $0.set(colors: SMUPAsset.smupMain3.color)
        $0.glowAmount = 0
        $0.trackThickness = 0.4
        $0.progressThickness = 0.4
        $0.roundedCorners = false
        $0.startAngle = -90
        $0.trackColor = SMUPAsset.smupGray3.color
    }
    private let currentDateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.textColor = SMUPAsset.smupGray6.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "오전 00시 00분\n곧 0교시 수업이 시작됩니다"
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = SMUPAsset.smupGray5.color
    }
    private let perioTimeLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.textColor = SMUPAsset.smupGray6.color
        $0.text = "start~end"
    }
    private let subjectLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.textColor = SMUPAsset.smupGray4.color
        $0.text = "과목"
    }
    
    override func layoutSubviews() {
        rootContainer.frame = self.bounds
        hourImageView.frame = rootContainer.bounds
        rootContainer.pin.all()
        rootContainer.flex.layout()
    }
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        hourImageView.image = SMUPAsset.smupClock.image
        hourImageView.contentMode = .scaleToFill
        self.addSubViews(rootContainer)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OpenMethod
    public func timeProcess(date: Date){
        let angle = 360 * (date.getCurrentTimeinterval() / 43200)
        circularView.animate(toAngle: angle, duration: 0.5, completion: nil)
        currentDateLabel.text = date.convertSchedule()
    }
}

private extension ClockView{
    func setLayout(){
        rootContainer.flex.define { flex in
            flex.addItem(hourImageView).width(bound.width*0.797).height(bound.width*0.797).define { flex in
                flex.addItem(circularView).width(bound.width*0.797).height(bound.width*0.797).define { flex in
                    flex.addItem().top(33%).height(33%).horizontally(0).justifyContent(.center).alignItems(.center).define { flex in
                        flex.addItem(currentDateLabel).horizontally(0)
                        flex.addItem(separatorView).width(55%).height(3)
                        flex.addItem(perioTimeLabel).horizontally(0)
                        flex.addItem(subjectLabel).horizontally(0)
                    }
                }
            }
        }
    }
}
