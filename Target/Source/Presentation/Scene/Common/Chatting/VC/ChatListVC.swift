//
//  ChatListVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class ChatListVC: baseVC<ChatListReactor>{
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private let chatListTableView = UITableView()
}
