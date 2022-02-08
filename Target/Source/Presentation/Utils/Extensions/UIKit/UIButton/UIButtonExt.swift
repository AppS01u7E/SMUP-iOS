//
//  UIButtonExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel?.text ?? .init())
            let titleSize = labelString.size(withAttributes: [
                .font: self.titleLabel?.font ?? .init()
            ])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
}
