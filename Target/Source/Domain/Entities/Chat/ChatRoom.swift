//
//  ChatRoom.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

struct ChatRoom: Codable {
    let id: String
    let isDone: Bool
    let name: String
    let profile: String
    let type: ChatRoom.`Type`
    let unreadCount: Int
    enum `Type`: String, Codable {
        case group = "GROUP"
        case interview = "INTERVIEW"
    }
}
