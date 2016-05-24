//
//  ArticleModel.swift
//  NyTimesArticleSearch
//
//  Created by Bharath Kongara on 5/22/16.
//  Copyright © 2016 Bharath Kongara. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ArticleModel: Object, Mappable {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var leadParagraph:String?
    dynamic var url:String?
    
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        leadParagraph <- map["lead_paragraph"]
        url <- map["web_url"]
    }
}
