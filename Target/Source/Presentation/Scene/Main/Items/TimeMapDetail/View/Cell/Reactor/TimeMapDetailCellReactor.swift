//
//  TimeMapDetailCellReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import ReactorKit

final class TimeMapDetailCellReactor: Reactor{
    enum Action{
        case goDirect
    }
    
    let initialState: TimeMap
    
    init(initialState: TimeMap) {
        self.initialState = initialState
    }
}
