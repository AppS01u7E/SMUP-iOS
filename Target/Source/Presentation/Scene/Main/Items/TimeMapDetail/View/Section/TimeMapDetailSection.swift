//
//  TimeMapDetailSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

enum TimeMapDetailSection{
    case first([TimeMapDetailSectionItem])
}

enum TimeMapDetailSectionItem{
    case main(TimeMapDetailCellReactor)
}

extension TimeMapDetailSection: SectionModelType{
    var items: [TimeMapDetailSectionItem]{
        switch self{
        case let .first(item): return item
        }
    }
    init(original: TimeMapDetailSection, items: [TimeMapDetailSectionItem]) {
        switch original{
        case .first: self = .first(items)
        }
    }
}
