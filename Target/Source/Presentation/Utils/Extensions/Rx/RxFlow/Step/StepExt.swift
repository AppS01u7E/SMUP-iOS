//
//  StepExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow

extension Step{
    var asSMUPStep: SMUPStep? {
        return self as? SMUPStep
    }
}
