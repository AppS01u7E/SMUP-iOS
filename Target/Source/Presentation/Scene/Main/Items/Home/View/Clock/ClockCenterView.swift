//
//  ClockCenterView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/30.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class ClockCenterView: UIView{
    // MARK: - Properties
    private let circleLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 8, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 5.0
        circleLayer.strokeColor = UIColor.black.cgColor
    }
    
    init(){
        super.init(frame: .zero)
        
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
