//
//  MainTabbarVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Floaty
import SnapKit
import Then
import RxCocoa
import RxSwift

final class MainTabbarVC: UITabBarController {
    // MARK: - Properties
    private let floaty = Floaty().then {
        $0.openAnimationType = .slideLeft
        $0.buttonColor = SMUPAsset.smupFloaty.color
        $0.itemButtonColor = SMUPAsset.smupFloaty.color
        $0.size = 64
    }
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        addView()
        setLayout()
        configureVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Method
    func setViewControllers(viewControllers: [UIViewController]? ,floaties: [FloatyItem]?, animated: Bool) {
        self.setViewControllers(viewControllers, animated: animated)
        guard let floaties = floaties else {
            return
        }
        
        floaties.enumerated().forEach { item in
            item.element.handler = { _ in
                self.didSelectFloatyItem(item.offset)
            }
            item.element.size = 44
            floaty.addItem(item: item.element)
        }
    }
}

// MARK: - UI
private extension MainTabbarVC{
    func addView(){
        self.view.insertSubview(floaty, belowSubview: self.tabBar)
        
    }
    func setLayout(){
        floaty.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(64)
        }
    }
    func configureVC(){
        self.tabBar.isHidden = true
        floaty.buttonImage = UIImage(systemName: "house")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
}

// MARK: - Method
private extension MainTabbarVC{
    func didSelectFloatyItem(_ index: Int) {
        self.selectedIndex = index
        self.floaty.buttonImage = self.floaty.items[index].icon
    }
}

