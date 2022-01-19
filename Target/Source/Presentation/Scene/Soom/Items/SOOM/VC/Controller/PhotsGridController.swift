//
//  PhotsGridController.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import LBTATools

class PhotoGridCell : LBTAListCell<String> {
    
    override func setupViews() {
        self.layer.cornerRadius = 10
        backgroundColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1)
    }
}

final class
PhotosGridController : LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        self.items = ["1", "2", "3"]
        
    }
    
    override func prepare() {
        
    }
    
    let cellSpacing : CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 0.5 * cellSpacing) / 2
        if indexPath.item == 0 {
            return .init(width: width, height: width)
        }
        return .init(width: width, height: width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
