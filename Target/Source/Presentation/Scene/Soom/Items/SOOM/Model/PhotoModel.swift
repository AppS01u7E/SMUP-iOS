//
//  PhotoModel.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

struct PhotoModel {
    let color : UIColor
    let contentHeightSize : CGFloat

    static func getMock() -> [Self] {

        var datas: [PhotoModel] = []

        for i in 0..<4 {

            if i == 2 {
                let imageHeightSize = CGFloat(50)
                let photoModel : PhotoModel = .init(color : .white, contentHeightSize: imageHeightSize)
                
                datas += [photoModel]
            }
            else if i != 0 {

                let imageHeightSize = CGFloat(192.5/2 - 2)
                let photoModel : PhotoModel = .init(color : .lightGray, contentHeightSize: imageHeightSize)
                
                datas += [photoModel]
            }
            else {
                let imageHeightSize = CGFloat(192.5)
                let photModel : PhotoModel = .init(color : .lightGray, contentHeightSize: imageHeightSize)
                
                datas += [photModel]
            }
        }



        return datas
    }
    
}
