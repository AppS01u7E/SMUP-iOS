//
//  SOOMVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxSwift
import LBTATools
import ReactorKit

class PostCell : LBTAListCell<String> {
    
    let imageView = UIImageView(backgroundColor: UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1))
    let nameLabel = UILabel(text: "1학년 4반")
    let dataLabel = UILabel(text: "28분 전")
    let postTextLabel = UILabel(text: "다음 주 운영체제 프로젝트 마감입니다!")
    let ellipsis = UIButton()
    let heart = UIButton()
    let heartCount = UILabel(text: "12")
    let chat = UIButton()
    let chatCount = UILabel(text: "4")
//    let imageViewGrid = UIView(backgroundColor: .gray)
    
    let photosGridController = ViewController()

    override func setupViews() {
        backgroundColor = .white
        
        imageView.layer.cornerRadius = 5
        nameLabel.font = UIFont.systemFont(ofSize: CGFloat(10), weight: .semibold)
        dataLabel.font = UIFont.systemFont(ofSize: CGFloat(9), weight: .regular)
        postTextLabel.font = UIFont.systemFont(ofSize: CGFloat(12), weight: .regular)
        ellipsis.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        ellipsis.tintColor = .gray
        heart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        heart.contentMode = .scaleToFill
        heart.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        heart.tintColor = UIColor(red: 200/255.0, green: 129/255.0, blue: 255/255.0, alpha: 1)
        heartCount.textColor = UIColor(red: 200/255.0, green: 129/255.0, blue: 255/255.0, alpha: 1)
        chat.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        chat.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        chat.tintColor = UIColor(red: 157/255.0, green: 157/255.0, blue: 157/255.0, alpha: 1)
        chatCount.textColor = UIColor(red: 157/255.0, green: 157/255.0, blue: 157/255.0, alpha: 1)

        
        stack(hstack(imageView.withWidth(46).withHeight(46),
                     stack(nameLabel, dataLabel).padTop(6).padBottom(6),stack(ellipsis).padLeft(240),
                     spacing: 12).padTop(12),
                postTextLabel,
                photosGridController.view,
              hstack(heart, heartCount,chat,chatCount, spacing: 7).padRight(300),
              spacing: 11).padLeft(12).padRight(12).padBottom(9)
    }
}

class StoryHeader : UICollectionReusableView {
    
    let storiesController = StoriesController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1)
        
        stack(storiesController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class StoryPhotoCell : LBTAListCell<SoomHeaderModel> {
    
    let uiLabel = UILabel(text: "info")
    let sublabel = UILabel(text: "동아리를 설명...")
    let imageView = UIImageView(backgroundColor: .white)
    let button = UIButton()

    lazy var containerView: UIView = {
        let view = UIView()

        return view
    }()
    
    override var item: SoomHeaderModel!{
        didSet{
            uiLabel.text = item.title
            sublabel.text = item.description
            self.backgroundColor = item.color
            // TODO: 
        }
    }
    
    override func setupViews() {
        
        imageView.layer.cornerRadius = 5
        
        uiLabel.textColor = .white
        uiLabel.font = UIFont.systemFont(ofSize: CGFloat(13), weight: .medium)
        sublabel.textColor = .white
        sublabel.font = UIFont.systemFont(ofSize: CGFloat(11), weight: .regular)
        
        stack(hstack(imageView.withHeight(54).withWidth(34),stack(uiLabel,sublabel).padTop(12).padBottom(12), spacing: 5)).padLeft(8).padTop(7).padBottom(7).padRight(10)
        
        self.layer.cornerRadius = 10
        
    }
    
}

class StoriesController : LBTAListController<StoryPhotoCell, SoomHeaderModel>, UICollectionViewDelegateFlowLayout {
    
    var dataSource : [SoomHeaderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        
        self.items = SoomHeaderModel.getMock()
        
        
    }
    private func setupDataSource() {
        dataSource = SoomHeaderModel.getMock()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 128, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }

}

final class SOOMVC : LBTAListHeaderController<PostCell, String, StoryHeader>,UICollectionViewDelegateFlowLayout, View
{
    
    private let alarmButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "bell")?.tintColor(.black)
    }
    
    var disposeBag = DisposeBag()

    func bind(reactor: SOOMReactor) {}
        
    @Inject var reactor: SOOMReactor

    init(reactor: SOOMReactor){
        super.init()
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["hello","world", "1", "2"]
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = alarmButton
        self.navigationController?.navigationBar.backgroundColor = .white
        let statusBar = UIView()

        statusBar.frame = UIApplication.shared.statusBarFrame

        statusBar.backgroundColor = .white

        UIApplication.shared.keyWindow?.addSubview(statusBar)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        return .init(width: view.frame.width, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 4, left: 0, bottom: 0, right: 0)
    }
}

