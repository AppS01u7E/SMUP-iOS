//
//  MainTabbarVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import JJFloatingActionButton
import RxFlow

final class MainTabbarVC: UITabBarController, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return SMUPStep.mainTabbarIsRequired
    }
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        configureVC()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
private extension MainTabbarVC{
    func configureVC(){
        self.delegate = self
        self.tabBar.tintColor = UIColor(red: 0.636, green: 0.273, blue: 1, alpha: 1)
    }
}

// MARK: - Extension
extension MainTabbarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 1{
            self.steps.accept(SMUPStep.soomTabbarIsRequired)
        }
    }
}
