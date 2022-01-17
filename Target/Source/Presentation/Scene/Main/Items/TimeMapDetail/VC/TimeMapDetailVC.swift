//
//  TimeMapDetailVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import UIKit

final class TimeMapDetailVC: baseVC<TimeMapDetailReactor>{
    // MARK: - Properties
    private let timeMapsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Init
    init(schedules: [TimeMap]){
        super.init()
        Observable.just(schedules)
            .map { Reactor.Action.`init`($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
