//
//  ChattingVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import MessageKit
import InputBarAccessoryView
import ReactorKit
import RxCocoa
import RxSwift

final class ChattingVC: MessagesViewController {
    // MARK: - Properties
    typealias Reactor = ChattingReactor
    private let plusButton = InputBarButtonItem(image: .init(systemName: "plus.circle")?.tintColor(SMUPAsset.smupMain1.color) ?? .init(),
                                                tintColor: SMUPAsset.smupMain1.color,
                                                target: nil,
                                                action: nil)
    var disposeBag: DisposeBag = .init()
    // MARK: - Init
    init(reactor: ChattingReactor, isDone: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.messageInputBar.isHidden = isDone
        self.reactor = reactor
        setDelegate()
        configureVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
}

// MARK: - UI
private extension ChattingVC {
    func setDelegate() {
//        messagesCollectionView.messagesDisplayDelegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
    }
    func configureVC() {
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.setStackViewItems([plusButton], forStack: .left, animated: false)
        removeOutgoingMessageAvatar()
        configureInputBar()
    }
    
    func removeOutgoingMessageAvatar() {
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else { return }
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.setMessageOutgoingAvatarSize(.zero)
        let outgoingAlignment = LabelAlignment(textAlignment: .right, textInsets: .init(top: 0, left: 0, bottom: 0, right: 0))
        layout.setMessageOutgoingCellTopLabelAlignment(outgoingAlignment)
    }
    func configureInputBar() {
        messageInputBar.sendButton.setTitle("", for: .normal)
        messageInputBar.sendButton.setImage(.init(systemName: "paperplane")?.tintColor(SMUPAsset.smupMain1.color).downSample(size: .init(width: 15, height: 15)), for: .normal)
        messageInputBar.inputTextView.placeholder = "입력해주세요..."
        messageInputBar.inputTextView.backgroundColor = SMUPAsset.smupGray3.color
        messageInputBar.inputTextView.layer.cornerRadius = 5
    }
    
}

// MARK: - MessageKit


// MARK: - Reactor
extension ChattingVC: ReactorKit.View {
    func bind(reactor: Reactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
        bindView(reactor: reactor)
    }
}

private extension ChattingVC {
    func bindAction(reactor: ChattingReactor) {
        
    }
    func bindState(reactor: ChattingReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
    }
    func bindView(reactor: ChattingReactor) {
        
    }
}
