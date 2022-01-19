//
//  ImageMediaItem.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import MessageKit

struct ImageMediaItem: MediaItem{
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    init(image: UIImage, url: URL? = nil) {
        self.url = url
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
}
