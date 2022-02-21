//
//  SOOMReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SOOMReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewWillAppear
        case alarmButtonDidTap
    }
    enum Mutation{
        case setSoomStory([SoomHeaderModel])
        case setSoomPost([SOOMPost])
    }
    struct State{
        var soomStorys: [SoomHeaderModel] = []
        var soomPosts: [SOOMPost] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SOOMReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .alarmButtonDidTap :
            steps.accept(SMUPStep.alarmIsRequired)
            return .empty()
        case .viewWillAppear:
            return .just(.setSoomPost(getSoomPostMock()))
        }
    }
}

// MARK: - Reduce
extension SOOMReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSoomStory(story):
            newState.soomStorys = story
        case let .setSoomPost(post):
            newState.soomPosts = post
        }
        return newState
    }
}


// MARK: - Method
private extension SOOMReactor{
    func getSoomStoryMock() -> [SoomHeaderModel] {
        return [
            .init(color: UIColor(red: 119/255, green: 213/255, blue: 242/255, alpha: 1), title: "info", description: "동아리를 설명...", imageUrl: ""),
            .init(color: UIColor(red: 255/255, green: 224/255, blue: 61/255, alpha: 1), title: "info", description: "동아리를 설명...", imageUrl: ""),
            .init(color: UIColor(red: 195/255, green: 125/255, blue: 250/255, alpha: 1), title: "info", description: "동아리를 설명...", imageUrl: ""),
        ]
    }
    func getSoomPostMock() -> [SOOMPost] {
        return [
            .init(id: "",profileImageUrl: "", ownerImageUrl: "", owner: "1학년 4반", postDate: Date(), title: "다음 주 운영체제 프로젝트 마감입니다!", postImageUrl: ["", "", ""], heartNumber: 12, commentNumber: 4,commenterProfileImageUrl: "", commenterName: "Name", commentDate: Date(), comment: "안녕하세요"),
            .init(id: "",profileImageUrl: "", ownerImageUrl: "", owner: "1학년 4반", postDate: Date(), title: "다음 주 운영체제 프로젝트 마감입니다!", postImageUrl: ["", "", ""], heartNumber: 12, commentNumber: 4,commenterProfileImageUrl: "", commenterName: "Name", commentDate: Date(), comment: "안녕하세요"),
            .init(id: "",profileImageUrl: "", ownerImageUrl: "", owner: "1학년 4반", postDate: Date(), title: "다음 주 운영체제 프로젝트 마감입니다!", postImageUrl: ["", "", ""], heartNumber: 12, commentNumber: 4,commenterProfileImageUrl: "", commenterName: "Name", commentDate: Date(), comment: "안녕하세요"),
        ]
    }
}
