//
//  NavigationExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

extension UINavigationItem{
    func setTitle(title: String){
        let lb = UILabel()
        lb.text = title
        lb.textColor = .black
        lb.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 24)
        self.titleView = lb
    }
}
