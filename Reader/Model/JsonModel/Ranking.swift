//
//  Ranking.swift
//  Reader
//
//  Created by WZY on 2017/11/23.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import HandyJSON

struct Ranking: Codable {
    var male: [RankingBySex]?
    var female: [RankingBySex]?
    var ok: Bool?
}

struct RankingBySex: Codable {
    var _id: String?
    var title: String?
    var cover: String?
    var collapse: Bool?
    var monthRank: String?
    var totalRank: String?
    var shortTitle: String?
}
