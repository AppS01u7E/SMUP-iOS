//
//  ChattingVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import ReactorKit
import MessageKit

final class ChattingVC: MessagesViewController{
    // MARK: - Properties
    @Inject var reactor: ChattingReactor
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: - Init
    init(ID: String){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension ChattingVC{
    func addView(){
        
    }
    func setLayout(){
        
    }
    func configureVC(){
        
    }
}

// MARK: - Reactor
extension ChattingVC: ReactorKit.View{
    func bind(reactor: ChattingReactor) {
        bindView(reactor: reactor)
        bindState(reactor: reactor)
        bindActions(reactor: reactor)
    }
    func bindView(reactor: ChattingReactor){
        
    }
    func bindState(reactor: ChattingReactor){
        
    }
    func bindActions(reactor: ChattingReactor){
        
    }
}
