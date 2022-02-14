//
//  UITextFieldExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftImage(image: UIImage) {
        let leftImage = UIImageView(image: image)
        self.leftView = leftImage
        self.leftViewMode = .always
    }
}
