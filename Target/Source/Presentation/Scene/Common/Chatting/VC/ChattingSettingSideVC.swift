//
//  ChattingSettingSideVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SideMenu
import UIKit

final class ChattingSettingSideVC: baseVC<ChattingReactor>{
    // MARK: - Properties
    private let titleLabel = UILabel()
    
    
    // MARK: - UI
    override func configureVC() {
        self.view.backgroundColor = .systemBlue
    }
}
