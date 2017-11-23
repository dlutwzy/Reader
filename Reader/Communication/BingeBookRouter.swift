//
//  Router.swift
//  Reader
//
//  Created by WZY on 2017/11/22.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireRouterReuqest {
    func request() -> DataRequest
}

func AlamofireRequest(url: URLRequestConvertible)-> DataRequest {
    return Alamofire.request(url)
}

enum BingeBookRouter: URLRequestConvertible, AlamofireRouterReuqest {
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
        start: Int,
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
    
    static let baseURLString = "https://api.zhuishushenqi.com"
    static let baseImgUrlString = "https://statics.zhuishushenqi.com"

    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .ranking:
                return ("/ranking/gender", [:])
            case .rankingDetail(let rankingId):
                return ("/ranking/\(rankingId)", [:])
            case .bookDetail(let bookId):
                return ("/book/\(bookId)", [:])
            case .hotReviews(let bookId):
                return ("/post/review/best-by-book", ["book": bookId])
            case .recommendList(let bookId, let limit):
                return ("book-list/\(bookId)/recommend", ["limit": limit])
            case .hotWords:
                return ("/book/hot-word", [:])
            case .bookNameAutoComplete(let partName):
                return ("/book/auto-complete", ["query": partName])
            case .searchBookByName(let bookName):
                return ("/book/fuzzy-search", ["query": bookName])
            case .comprehensiveList(let block, let duration, let sort, let type, let distillate, let start, let limit):
                return ("/book/by-block", [
                    "block": block.rawValue,
                    "duration": duration.rawValue,
                    "sort": sort.rawValue,
                    "type": type,
                    "distiallate": distillate,
                    "start": start,
                    "limit": limit
                    ])
            case .helps(let duration, let sort, let start, let limit, let distillate):
                return ("/post/help", [
                    "duration": duration.rawValue,
                    "sort": sort.rawValue,
                    "start": start,
                    "limit": limit,
                    "distillate": distillate
                    ])
            case .bookReviews(let duration, let sort, let type, let start, let limit, let distillate):
                return ("/post/review", [
                    "duration": duration.rawValue,
                    "sort": sort.rawValue,
                    "type": type,
                    "start": start,
                    "limit": limit,
                    "distillate": distillate
                    ])
            case .categoryList:
                return ("/cats/lv2/statistics", [:])
            case .chapters(let bookId):
                return ("/mix-atoc/\(bookId)", ["view": "chapters"])
            }
        }()
        
        let url = try  BingeBookRouter.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }

    func request() -> DataRequest {
        return AlamofireRequest(url: self)
    }
}

enum BookContentRouter:URLRequestConvertible, AlamofireRouterReuqest {

    /// 获取章节内容
    case chapterContent(url: String)

    static let baseChapterURLString = "http://chapter2.zhuishushenqi.com"


    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .chapterContent(let url):
                return ("/chapter/\(url)", [:])
            }
        }()

        let url = try  BookContentRouter.baseChapterURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }

    func request() -> DataRequest {
        return AlamofireRequest(url: self)
    }
}

