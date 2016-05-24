//
//  ArticleListResponseModel.swift
//  NyTimesArticleSearch
//
//  Created by Bharath Kongara on 5/22/16.
//  Copyright © 2016 Bharath Kongara. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ArticleListResponseModel: Object , Mappable{
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
     var articles = List<ArticleModel>()
    //dynamic var articles:[ArticleModel]?
    dynamic var status:String?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        articles <- (map["response.docs"],ArrayTransform<ArticleModel>())
        status <- map["status"]
    }
    
}
