//
//  ChattingVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import ReactorKit
import MessageKit
import UIKit
import InputBarAccessoryView
import Then

final class ChattingVC: MessagesViewController{
    // MARK: - Properties
    @Inject var reactor: ChattingReactor
    
    var id: String
    var sender = Sender(senderId: "unique", displayName: "baegteun")
    
    var disposeBag: DisposeBag = .init()
    
    private let plusButton = InputBarButtonItem().then {
        $0.image = .init(systemName: "plus.circle")?.tintColor(.init(red: 0.588, green: 0.333, blue: 1, alpha: 1)).downSample(size: .init(width: 40, height: 40))
    }
    
    private let sideButton = UIBarButtonItem(image: .init(systemName: "list.bullet")?.tintColor(.black), style: .plain, target: self, action: nil)
    
    // MARK: - Init
    init(ID: String){
        self.id = ID
        super.init(nibName: nil, bundle: nil)
        setDelegate()
        configureVC()
        configureNavigation()
        Observable.just(id)
            .map { Reactor.Action.`init`($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}



// MARK: - UI
private extension ChattingVC{
    func setDelegate(){
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
    }
    func configureVC(){
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.setStackViewItems([plusButton], forStack: .left, animated: false)
        removeOutgoingMessageAvatar()
        configureInputBar()
        bind(reactor: reactor)
    }
    func configureNavigation(){
        self.navigationItem.rightBarButtonItem = sideButton
    }
    func removeOutgoingMessageAvatar() {
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else { return }
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.setMessageOutgoingAvatarSize(.zero)
        let outgoingLabelAlignment = LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15))
        layout.setMessageOutgoingMessageTopLabelAlignment(outgoingLabelAlignment)
    }
    func configureInputBar(){
        messageInputBar.sendButton.setTitle("", for: .normal)
        messageInputBar.sendButton.setImage(.init(systemName: "paperplane")?.tintColor(.init(red: 0.588, green: 0.333, blue: 1, alpha: 1)).downSample(size: .init(width: 15, height: 15)), for: .normal)
        messageInputBar.inputTextView.placeholder = "입력해주세요..."
        messageInputBar.inputTextView.backgroundColor = .systemGray6
        messageInputBar.inputTextView.layer.cornerRadius = 5
    }
}

// MARK: - Message
extension ChattingVC: MessagesDataSource{
    func currentSender() -> SenderType {
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return reactor.currentState.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return reactor.currentState.messages.count
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name,
                                  attributes: [
                                    .font : UIFont.preferredFont(forTextStyle: .caption1),
                                    .foregroundColor : UIColor(white: 0.3, alpha: 1)
                                  ])
    }
}

extension ChattingVC: MessagesLayoutDelegate{
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
}

extension ChattingVC: MessagesDisplayDelegate{
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let cell = messagesCollectionView.dequeueReusableCell(MessageCollectionViewCell.self, for: indexPath)
        cell.applyGradient(colors: [
            UIColor(red: 0.529, green: 0.239, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.749, green: 0.592, blue: 1, alpha: 1).cgColor
        ], locations: [
            0, 1
        ], startPoint: .init(x: 0, y: 1), endPoint: .init(x: 1, y: 1))
        
        return .init(red: 0.956, green: 0.956, blue: 0.956, alpha: 1)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .black
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let cornerDirection: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(cornerDirection, .curved)
    }
}

// MARK: - Reactor
extension ChattingVC: ReactorKit.View{
    func bind(reactor: ChattingReactor) {
        bindView(reactor: reactor)
        bindState(reactor: reactor)
        bindActions(reactor: reactor)
    }
    func bindView(reactor: ChattingReactor){
        messageInputBar.inputTextView.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.updateContent($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sideButton.rx.tap
            .map { Reactor.Action.sideButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    func bindState(reactor: ChattingReactor){
        
    }
    func bindActions(reactor: ChattingReactor){
        
    }
}
