//
//  UIStackViewExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

extension UIStackView{
    func addArrangeSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
