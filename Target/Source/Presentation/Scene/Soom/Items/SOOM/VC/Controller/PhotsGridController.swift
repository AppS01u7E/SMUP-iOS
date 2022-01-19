////
////  PhotsGridController.swift
////  SMUP
////
////  Created by Sunghun Kim on 2022/01/18.
////  Copyright © 2022 baegteun. All rights reserved.
////
//
//import UIKit
//import LBTATools
//
//class PhotoGridCell : LBTAListCell<String> {
//
//    let imageView = UIImageView(image: UIImage(named: "123"), contentMode: .scaleAspectFill)
//
//    override var item : String! {
//        didSet {
//            imageView.image = UIImage(named: item)
//        }
//    }
//
//    override func setupViews() {
//        self.layer.cornerRadius = 10
//        backgroundColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1)
//
//        stack(imageView)
//    }
//}
//
//final class
//PhotosGridController : LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
//        self.items = ["1", "2", "3"]
//
//    }
//
//    let cellSpacing : CGFloat = 10
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 0.5 * cellSpacing) / 2
//        if indexPath.item == 0 {
//            return .init(width: width, height: width)
//        }
//        return .init(width: width, height: width / 2)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//}


import UIKit
import Then

// 편의상 전역변수

let imagesCount = 21

var images: [UIImage] {return images }



class ViewController: UIViewController, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else{
            return UICollectionViewCell()
        }

        cell.imageView.image = images[indexPath.row]

        return cell

    }

}

class CollectionViewCell: UICollectionViewCell {

    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .green
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .red
        addSubViews(imageView)
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height/2)
    }

}

protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
 

    // 1
    weak var delegate: PinterestLayoutDelegate?

    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6

    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []

    // 4
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }

    // 5
    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }

    
    override func prepare() {
      // 1
      guard
        cache.isEmpty,
        let collectionView = collectionView
        else {
          return
      }
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset: [CGFloat] = []
      for column in 0..<numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
      // 3
      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
          
        // 4
        let photoHeight = delegate?.collectionView(
          collectionView,
          heightForPhotoAtIndexPath: indexPath) ?? 180
        let height = cellPadding * 2 + photoHeight
        let frame = CGRect(x: xOffset[column],
                           y: yOffset[column],
                           width: columnWidth,
                           height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
          
        // 5
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
          
        // 6
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        
        column = column < (numberOfColumns - 1) ? (column + 1) : 0
      }
    }

    
}


