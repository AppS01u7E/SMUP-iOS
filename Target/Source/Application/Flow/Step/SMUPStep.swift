//
//  SMUPStep.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow

enum SMUPStep: Step{
    // Global
    case alert(title: String?, message: String?)
    case dismiss
    
    // Auth
    case signInIsRequired
    case appleSignInIsRequired
    case signInIsCompleted
    
    // Main
    case mainTabbarIsRequired
    
    // Home
    case homeIsRequired
    
    // TimeMap
    case timeMapIsRequired
    
    // Chatting
    case chattingIsRequired
    
    // SOOM
    case soomIsRequired
    
    // Settings
    case settingIsRequired
}
