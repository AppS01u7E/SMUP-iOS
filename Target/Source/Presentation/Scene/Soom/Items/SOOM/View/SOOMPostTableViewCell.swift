//
//  PostTableViewCell.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/02/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import BTImageView
import PinLayout
import FlexLayout

final class SOOMPostTableViewCell : baseTableViewCell<SOOMPost>{
    // MARK: - Properties
    private var profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        $0.layer.cornerRadius = 5
    }
    
    private var ownerImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        $0.layer.cornerRadius = 17.5
    }
    
    private let ownerLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 10)
        $0.textColor = .black
    }
    
    private let ellipsis = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .gray
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 9)
        $0.textColor = .black
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = .black
    }
    
    private let postImageView = BTImageView().then {
        $0.aligns = [1, 2]
        $0.axis = .horizontal
        $0.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    }
    
    private var heart = UIButton().then {
        $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        $0.contentMode = .scaleToFill
        $0.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        $0.tintColor = UIColor(red: 200/255.0, green: 129/255.0, blue: 255/255.0, alpha: 1)
    }
    
    private var heartNumberLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = UIColor(red: 200/255.0, green: 129/255.0, blue: 255/255.0, alpha: 1)
    }
    
    private let chat = UIButton().then {
        $0.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        $0.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        $0.tintColor = UIColor(red: 157/255.0, green: 157/255.0, blue: 157/255.0, alpha: 1)
    }
    
    private var commentNumberLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = UIColor(red: 157/255.0, green: 157/255.0, blue: 157/255.0, alpha: 1)
    }
    
    private var commenterProfileImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        $0.layer.cornerRadius = 17.5
    }
    
    private let commentView = UIView().then{
        $0.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        $0.layer.cornerRadius = 8
    }
    
    private let comment = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 10)
        $0.tintColor = .black
    }
    
    private let commenterName = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 10)
        $0.tintColor = .black
    }
    
    private let commentDateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 9)
        $0.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private let commentLikeLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 9)
        $0.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.text = "좋아요"
    }
    
    private let commentCommentLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 9)
        $0.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.text = "답글달기"
    }
    
    private let writeComment = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.attributedPlaceholder = NSAttributedString(string: "댓글을 입력해주세요", attributes: [.font: UIFont(font: SMUPFontFamily.Inter.regular, size: 12)])
    }
    
    private let postButton = UIButton().then {
        $0.setImage(UIImage(systemName: "paperplane"), for: .normal)
        $0.tintColor = .lightGray
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(ownerImageView, ownerLabel, commentView, titleLabel, dateLabel, postImageView, heart, chat, heartNumberLabel, commentNumberLabel, commenterProfileImageView,profileImageView)
    }
    
    override func setLayoutSubViews() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func setLayout() {
        
        contentView.flex.paddingTop(25).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(profileImageView).size(46)
                flex.addItem().marginLeft(10).height(100%).marginTop(8).grow(1).define { flex in
                    flex.addItem(ownerLabel).paddingBottom(5)
                    flex.addItem(dateLabel)
                }
                flex.addItem(ellipsis).height(100%)
            }
            flex.addItem(titleLabel).marginTop(10).height(100%)
            flex.addItem(postImageView).marginTop(10).height(192)
            flex.addItem().height(100%).marginTop(20).marginLeft(5).direction(.row).define { flex in
                flex.addItem(heart)
                flex.addItem(heartNumberLabel).marginHorizontal(8)
                flex.addItem(chat)
                flex.addItem(commentNumberLabel).marginHorizontal(8)
            }
            flex.addItem().marginTop(25).direction(.row).define { flex in
                flex.addItem(commenterProfileImageView).size(35)
                flex.addItem(commentView).marginLeft(10).height(39).width(65).define { flex in
                    flex.addItem(commenterName).marginTop(6).marginLeft(9)
                    flex.addItem(comment).marginLeft(9)
                }
            }
            flex.addItem().marginTop(4).marginLeft(45).direction(.row).define { flex in
                flex.addItem(commentDateLabel).height(100%)
                flex.addItem(commentLikeLabel).height(100%).marginHorizontal(15)
                flex.addItem(commentCommentLabel).height(100%)
            }
            flex.addItem().marginTop(50).direction(.row).define { flex in
                flex.addItem(ownerImageView).size(35)
                flex.addItem(writeComment).height(100%).marginHorizontal(10).grow(1)
                flex.addItem(postButton).height(100%)
            }
        }
    }
    
    override func configureCell() {
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        setLayoutSubViews()
        return contentView.frame.size
    }
    
    override func bind(_ model: SOOMPost) {
        profileImageView.image = UIImage(named: "\(model.profileImageUrl)")
        ownerImageView.image = UIImage(named: "\(model.ownerImageUrl)")
        ownerLabel.text = model.owner
        dateLabel.text = "28분 전"
        titleLabel.text = model.title
        postImageView.setImages(images: [
            .init(named: "\(model.postImageUrl)") ?? .init(),
            .init(named: "\(model.postImageUrl)") ?? .init(),
            .init(named: "\(model.postImageUrl)") ?? .init(),
        ])
        heartNumberLabel.text = "\(model.heartNumber)"
        commentNumberLabel.text = "\(model.commentNumber)"
        commenterProfileImageView.image = UIImage(named: "\(model.commenterProfileImageUrl)")
        commenterName.text = model.commenterName
        comment.text = model.comment
        commentDateLabel.text = "50분"
        
    }
    
}
