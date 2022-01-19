//
//  Message.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import MessageKit
import UIKit

struct Message: MessageType{
    let id: String?
    var messageId: String{
        return id ?? UUID().uuidString
    }
    let content: String
    let sentDate: Date
    var sender: SenderType
    var kind: MessageKind{
        if let image = image{
            let media = ImageMediaItem(image: image, url: downloadURL)
            return .photo(media)
        }else{
            return .text(content)
        }
    }
    
    var image: UIImage?
    var downloadURL: URL?
    
    init(content: String, sender: SenderType = Sender(senderId: "TODO", displayName: "TODOOO")){
        self.sender = sender
        self.content = content
        sentDate = Date()
        id = nil
    }
    
    init(image: UIImage) {
        sender = Sender(senderId: "id(TODO...)", displayName: "displayName(TODO...)")
        self.image = image
        sentDate = Date()
        content = ""
        id = nil
    }
}

extension Message: Comparable{
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
      }

      static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
      }
}
