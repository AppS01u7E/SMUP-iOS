//
//  baseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import ReactorKit
import Then
import SnapKit
import Swinject

class baseVC<T: Reactor>: UIViewController{
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        addView()
        configureVC()
        configureNavigation()
    }
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    
    @Inject var reactor: T
    
    init(reactor: T){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func setUp(){}
    func addView(){}
    func setLayout(){}
    func configureVC(){}
    func configureNavigation(){}
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension baseVC: View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
