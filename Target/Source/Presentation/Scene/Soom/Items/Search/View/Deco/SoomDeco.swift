//
//  SoomDeco.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then

final class SoomDeco: UIView{
    // MARK: - Properties
    
    init(){
        super.init(frame: .init(x: 0, y: 0, width: 90, height: 18))
        self.backgroundColor = UIColor(red: 0.847, green: 0.698, blue: 1, alpha: 1)
        
        self.transform = .init(rotationAngle: 100)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
