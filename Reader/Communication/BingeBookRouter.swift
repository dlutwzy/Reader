//
//  Router.swift
//  Reader
//
//  Created by WZY on 2017/11/22.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import Alamofire

enum BingeBookRouter: URLRequestConvertible {
    //Delete
    case search(query: String, page: Int)
    
    /// 获取所有排行榜
    case ranking()

    /// 获取排行榜详细信息
    case rankingDetail(rankingId: String)
    /// 获取书籍详细信息
    case bookDetail(bookId: String)
    /// 获取热门评论
    case hotReviews(bookId: String)
    /// 获取推荐书单
    case recommendList(bookId: String, limit: String)
    /// 获取热门搜索
    case hotWords()
    /// 书名自动补全
    case bookNameAutoComplete(partName: String)
    /// 书名搜书
    case searchBookByName(bookName: String)

    ///**
    /// * 获取综合讨论区列表.
    /// *
    /// * @param block      ramble:综合讨论区
    /// *                   original：原创区
    /// * @param duration   all
    /// *                   girl 女
    /// * @param sort       updated(默认排序)
    /// *                   created(最新发布)
    /// *                   comment-count(最多评论)
    /// * @param type       all
    /// * @param distillate true(精品)
    /// * @param start      0
    /// * @param limit      20
    /// */
    case comprehensiveList(
        block: ComprehensiveBlock,
        duration: ComprehensiveDuration,
        sort: ComprehensiveSort,
        type: String,
        distillate: String,
        start: Int,
        limit: Int
    )

    /**
     * 书荒互助.
     *
     * @param duration   all
     * @param sort       updated(默认排序)
     *                   created(最新发布)
     *                   comment-count(最多评论)
     * @param start      0
     * @param limit      20
     * @param distillate true(精品) 、空字符（全部）
     * @return {@link ShortageEntity}
     */
    case helps(
        duration: ComprehensiveDuration,
        sort: ComprehensiveSort,
        stat: Int,
        limit: Int,
        distillate: String
    )

    /**
     * 书评列表.
     *
     * @param duration   all
     * @param sort       updated(默认排序)
     *                   created(最新发布)
     *                   helpful(最有用的)
     *                   comment-count(最多评论)
     * @param type       all(全部类型)
     * @param start      0
     * @param limit      20
     * @param distillate true(精品) 、空字符（全部）
     * @return {@link BookReviewEntity}
     */
    case bookReviews(
        duration: ComprehensiveDuration,
        sort: ComprehensiveSort,
        type: String,
        start: Int,
        limit: Int,
        distillate: String
    )

    /// 获取分类数组
    case categoryList()

    /// 获取章节列表
    case chapters(bookId: String)

    /// 获取章节内容
    case chapterContent(url: String)

    enum ComprehensiveBlock: String {
        ///综合讨论区
        case ramble = "ramble"
        ///原创区
        case original = "original"
    }

    enum ComprehensiveDuration: String {
        /// 全部
        case all = "all"
        /// 女生
        case girl = "girl"
    }

    enum ComprehensiveSort: String {
        /// 默认排序
        case updated = "updated"
        /// 根据时间
        case created = "created"
        /// 根据评论数量
        case commentCount = "comment-count"
    }
    
    static let baseURLString = "http://api.zhuishushenqi.com"
    static let baseImgUrlString = "http://statics.zhuishushenqi.com"

    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .search(query, page) where page > 0:
                return ("/search", ["q": query, "offset": Router.perPage * page])
            case let .search(query, _):
                return ("/search", ["q": query])
            case let .ranking():
                return ("/ranking/gender", [])
            case let .topDetails(rankingId):
                return ("/ranking/\(rankingId)", [])
            case let .bookDetails(bookId):
                return ("/book/\(bookId)", [])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}

