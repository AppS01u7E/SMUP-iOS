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

    // Soom
    case soomTabbarIsRequired
    
    // SOOM
    case soomIsRequired
    
    // MARK: - Main
    case homeIsRequired
    
    // MySchool
    case mySchoolIsRequired
    
    // TimeMap
    case timeMapIsRequired(selectedDate: Date)
    case timeMapDetailIsRequired(schedules: [TimeMap], current: Int)
    
    // Settings
    case settingIsRequired
    
    // MARK: - SOOM
    case soomHomeIsRequired
    
    // Settings
    case soomSettingIsRequired
    
    // Searching
    case soomSearchingIsRequired
    
    // MARK: - Common Tab
    
    // Chatting
    case chatListIsRequired
    case chattingIsRequired(withID: String)
    
    // Alarm
    case AlarmIsRequired
}
