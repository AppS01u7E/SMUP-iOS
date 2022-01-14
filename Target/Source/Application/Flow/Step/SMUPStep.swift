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
    
    // SOOM
    case soomIsRequired
    
    // MARK: - Main
    case homeIsRequired
    
    // TimeMap
    case timeMapIsRequired
    
    // Chatting
    case chattingIsRequired
    
    
    // Settings
    case settingIsRequired
    
    // MARK: - SOOM
}
