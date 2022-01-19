//
//  MyModel.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

struct MyModel {
    let color : UIColor
    
    static func getMock() -> [Self] {
        
        var datas : [MyModel] = []
        
        for i in 0..<3 {
            if i == 0 {
                let blue = UIColor.init(red: 119/255.0, green: 213/255.0, blue: 243/255.0, alpha: 1)
                let myModel : MyModel = .init(color: blue)
                datas += [myModel]
            }
            else if i == 1 {
                let yellow = UIColor.init(red: 255/255.0, green: 224/255.0, blue: 61/255.0, alpha: 1)
                let myModel : MyModel = .init(color: yellow)
                datas += [myModel]
            }
            else {
                let purple = UIColor.init(red: 195/255.0, green: 125/255.0, blue: 250/255.0, alpha: 1)
                let myModel : MyModel = .init(color: purple)
                datas += [myModel]
            }
            
        }
        
        return datas
    }
    
}
