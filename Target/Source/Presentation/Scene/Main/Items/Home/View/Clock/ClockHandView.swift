//
//  ClockHandView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/30.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import PinLayout

final class ClockHandView: UIView {
    // MARK: - Properties
    private let view = UIView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 2
    }
    
    override func layoutSubviews() {
        view.pin.bottomCenter(to: self.anchor.center).width(100%).height(50%)
    }
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        self.addSubViews(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
