//
//  RankingDetails.swift
//  Reader
//
//  Created by WZY on 2017/11/23.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import HandyJSON

struct RankingDetail: HandyJSON {
    var ok: Bool?
    var ranking: RankingContent?
}

struct RankingContent: HandyJSON {
    var __v: Int?
    var _id: String?
    var collapse: Bool?
    var cover: String?
    var created: String?
    var gender: String?
    var id: String?
    var isSub: Bool?
    var newX: Bool?
    var priority: Int?
    var tag: String?
    var title: String?
    var total: Int?
    var updated: String?
    var books: [RankingBookDetail]?
}

struct RankingBookDetail: HandyJSON {
    var _id: String?
    var author: String?
    /// 禁止？
    var banned: Int?
    var cover: String?
    var latelyFollwser: Int?
    /// 留存比？
    var retentionRatio: String?
    var shortIntro: String?
    var site: String?
    var title: String?
}
