//
//  MyModel.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

struct SoomHeaderModel {
    let color : UIColor
    let title: String
    let description: String
    let imageUrl: String
    
    static func getMock() -> [Self] {
        
        var datas : [SoomHeaderModel] = []
        
        for i in 0..<3 {
            if i == 0 {
                let blue = UIColor.init(red: 119/255.0, green: 213/255.0, blue: 243/255.0, alpha: 1)
                let myModel : SoomHeaderModel = .init(color: blue, title: "Info.plist", description: "이것은 파란색입니다", imageUrl: "https://avatars.githubusercontent.com/u/68891494?s=48&v=4")
                datas += [myModel]
            }
            else if i == 1 {
                let yellow = UIColor.init(red: 255/255.0, green: 224/255.0, blue: 61/255.0, alpha: 1)
                let myModel : SoomHeaderModel = .init(color: yellow, title: "피크닉", description: "\"절망\"", imageUrl: "https://avatars.githubusercontent.com/u/83396399?s=64&v=4")
                datas += [myModel]
            }
            else {
                let purple = UIColor.init(red: 195/255.0, green: 125/255.0, blue: 250/255.0, alpha: 1)
                let myModel : SoomHeaderModel = .init(color: purple, title: "누구세요", description: "설명입니다설명입니다설명입니다설명입니다설명입니다", imageUrl: "https://avatars.githubusercontent.com/u/74440939?v=4")
                datas += [myModel]
            }
            
        }
        
        return datas
    }
    
}
