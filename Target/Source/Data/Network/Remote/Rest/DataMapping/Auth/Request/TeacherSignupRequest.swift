//
//  TeacherSignupRequest.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

struct TeacherSignupRequest: Codable {
    let emailToken: String
    let firstName: String
    let lastName: String
    let gender: User.Gender
    let birth: String
    let password: String
    let teacherType: TeacherType
    let major: String
    let teacherCode: String
}
