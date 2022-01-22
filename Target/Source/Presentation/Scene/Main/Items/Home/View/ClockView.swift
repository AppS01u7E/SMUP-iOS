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

final class ClockView: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    private let rootContainer = UIView()
    private let hourImageView = UIImageView()
    private let circularView = KDCircularProgress().then {
        $0.set(colors: UIColor(red: 0.665, green: 0.411, blue: 0.988, alpha: 1))
        $0.trackThickness = 0.4
        $0.progressThickness = 0.4
        $0.startAngle = -90
        $0.trackColor = .systemGray5
    }
    private let currentDateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
    }
    
    private var task: Task!
    
    override func layoutSubviews() {
        rootContainer.frame = self.bounds
        hourImageView.frame = rootContainer.bounds
        rootContainer.pin.all()
        rootContainer.flex.layout(mode: .adjustHeight)
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
    public func start(){
        let angle = 360 * (Date().getCurrentTimeinterval() / 43200)
        self.circularView.animate(toAngle: angle, duration: 0.5, completion: nil)
        task = Plan.after(0.second, repeating: 1.minutes).do {
            let angle = 360 * (Date().getCurrentTimeinterval() / 43200)
            self.circularView.animate(toAngle: angle, duration: 0.5, completion: nil)
        }
    }
    public func end(){
        task.removeAllActions()
    }
}

private extension ClockView{
    func setLayout(){
        rootContainer.flex.define { flex in
            flex.addItem(hourImageView).width(bound.width*0.797).height(bound.width*0.797).define { flex in
                flex.addItem(circularView).width(bound.width*0.797).height(bound.width*0.797).define { flex in
                    flex.addItem(currentDateLabel).top(33%)
                }
            }
        }
    }
}
