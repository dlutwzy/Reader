//
//  BingeBookRequest.swift
//  Reader
//
//  Created by WZY on 2017/11/23.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import Alamofire

class BingeBookRequest {
    static func getRanking(responseBlcok: @escaping (Ranking?) -> Void) {
        BingeBookRouter.ranking().request().responseString(completionHandler: { (res) in
            //responseBlcok(Ranking.deserialize(from: res.result.value))
        })
    }

    static func getRankingBookDetail(rankingId: String, responseBlock: @escaping (RankingBookDetail?) -> Void) {
        BingeBookRouter.rankingDetail(rankingId: rankingId).request().responseString { (res) in
            
        }
    }
}
