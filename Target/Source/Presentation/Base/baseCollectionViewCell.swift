//
//  baseCollectionViewCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

class baseCollectionViewCell<T>: UICollectionViewCell{
    let bound = UIScreen.main.bounds
    lazy var disposeBag: DisposeBag = .init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setLayoutSubViews()
    }
    func addView(){}
    func setLayout(){}
    func setLayoutSubViews(){}
    func configureCell(){}
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func bind(_ model: T){}
}

class BaseCollectionViewCell<T: Reactor>: UICollectionViewCell{
    let bound = UIScreen.main.bounds
    lazy var disposeBag: DisposeBag = .init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addView(){}
    func setLayout(){}
    func configureCell(){}
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension BaseCollectionViewCell: ReactorKit.View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
