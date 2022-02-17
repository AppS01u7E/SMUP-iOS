//
//  SettingIconView.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class SettingIconButton: UIButton {
    // MARK: - Init
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        setImage(image.downSample(size: .init(width: 20, height: 20)).tintColor(SMUPAsset.smupGray6.color), for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(SMUPAsset.smupGray6.color, for: .normal)
        titleLabel?.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 14)
        alignTextBelow(spacing: 3)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
