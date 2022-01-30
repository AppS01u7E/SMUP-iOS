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
import Schedule
import SwiftDate

final class ClockView: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    private let clockImageView = UIImageView()
    private let centerView = ClockCenterView()
    private let hourHandView = ClockHandView()
    private let minHandView = ClockHandView()
    private let scheduleContainer = UIView()
    private let currentDateLabel = UILabel().then {
        $0.text = "오전 00시 00분\n곧 1교시 수업이 시작됩니다"
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    }
    private let perioTimeLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.text = "start~end"
    }
    private let subjectLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
        $0.textColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
        $0.text = "과목"
    }
    private var timer: Timer!
    
    override func layoutSubviews() {
        clockImageView.frame = self.bounds
        setLayout()
    }
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        clockImageView.image = SMUPAsset.smupClock.image
        clockImageView.contentMode = .scaleToFill
        self.addSubViews(clockImageView, hourHandView, minHandView, centerView, scheduleContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OpenMethod
    public func start(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeProcess(_:)), userInfo: nil, repeats: true)
    }
    public func end(){
        timer.invalidate()
    }
    
    @objc private func timeProcess(_ sender: Timer){
        let date = Date().convertKorea()
        let hourValue = (60*date.hour) + date.minute
        let hourAngle = CGAffineTransform(rotationAngle: 2.0 * .pi * CGFloat(hourValue) / (60*12))
        let minAngle = CGAffineTransform(rotationAngle: 2.0 * .pi * CGFloat(date.minute) / 60)
        UIView.animate(withDuration: 0.75) {
            self.hourHandView.transform = hourAngle
            self.minHandView.transform = minAngle
        }
        
        currentDateLabel.text = date.convertSchedule()
    }
}

private extension ClockView{
    func setLayout(){
        clockImageView.pin.top().horizontally().width(100%).height(frame.width)
        centerView.pin.center(to: clockImageView.anchor.center).width(20).height(20)
        hourHandView.pin.center(to: clockImageView.anchor.center).height(bound.width*0.12*2).width(4)
        minHandView.pin.center(to: clockImageView.anchor.center).height(bound.width*0.195*2).width(4)
        scheduleContainer.pin.horizontally().below(of: clockImageView, aligned: .none).marginTop(15).bottom()
        
        scheduleContainer.flex.alignItems(.center).define { flex in
            flex.addItem(currentDateLabel).width(100%).height(60)
            flex.addItem(separatorView).height(3).width(80%)
            flex.addItem(perioTimeLabel).horizontally(0)
            flex.addItem(subjectLabel).horizontally(0)
        }
        
        scheduleContainer.flex.layout()
    }
}
