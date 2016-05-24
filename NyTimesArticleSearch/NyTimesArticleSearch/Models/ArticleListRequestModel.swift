//
//  ArticleListRequestModel.swift
//  NyTimesArticleSearch
//
//  Created by Bharath Kongara on 5/22/16.
//  Copyright © 2016 Bharath Kongara. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ArticleListRequestModel: Object, Mappable {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    dynamic var query:String?
    dynamic var articlesFromDate:NSDate?
    dynamic var articlesToDate:NSDate?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        query <- map["q"]
        articlesFromDate <- map["begin_date"]
        articlesToDate <- map["end_date"]
    }
    
    func dateFromString(dateString:String) -> NSDate{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.dateFromString(dateString)
        return date!
    }
    
}
