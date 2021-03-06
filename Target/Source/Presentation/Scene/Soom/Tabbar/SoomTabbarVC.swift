//
//  MainTabbarVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import PinLayout
import Then
import RxCocoa
import RxSwift
import JJFloatingActionButton
import RxFlow

final class SoomTabbarVC: UITabBarController, Stepper {
    // MARK: - Properties
    private let floaty = JJFloatingActionButton().then {
        $0.buttonAnimationConfiguration = .transition(toImage: .init(systemName: "xmark") ?? .init())
        $0.itemAnimationConfiguration = .slideIn()
        $0.buttonColor = SMUPAsset.smupFloaty.color
    }
    
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SMUPStep.soomTabbarIsRequired
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
    func setViewControllers(viewControllers: [UIViewController]? ,floaties: [JJActionItem]?, animated: Bool) {
        self.setViewControllers(viewControllers, animated: animated)
        guard let floaties = floaties else {
            return
        }
        floaties.enumerated().forEach { item in
            if item.offset == 4{
                item.element.action = { _ in
                    self.steps.accept(SMUPStep.mainTabbarIsRequired)
                }
            }else{
                item.element.action = { _ in
                    self.didSelectFloatyItem(item.offset)
                }
            }
            item.element.buttonColor = SMUPAsset.smupFloaty.color
            floaty.addItem(item.element)
        }
    }
    func setFlaotyButtonHidden(_ hide: Bool){
        self.floaty.isHidden = hide
    }
}

// MARK: - UI
private extension SoomTabbarVC{
    func addView(){
        self.view.addSubViews(floaty)
    }
    func setLayout(){
        floaty.pin.bottomRight(30).size(64)
    }
    func configureVC(){
        self.tabBar.isHidden = true
        floaty.buttonImage = UIImage(systemName: "rectangle.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
}

// MARK: - Method
private extension SoomTabbarVC{
    func didSelectFloatyItem(_ index: Int) {
        self.selectedIndex = index
        self.floaty.buttonImage = self.floaty.items[index].buttonImage
    }
}

