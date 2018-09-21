//
//  TTDiaryData.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 21..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol TTCanHasDiaryData {
    var diaryData : TTDiaryData? { get set }
}

struct TTDiaryData {
    var id        : Int?
    var user_id   : Int?
    var content   : String?
    var location  : String?
    var imageUrl  : URL?
    var latitude  : Float?
    var longitude : Float?
    var like      : Int?
    var shared    : Bool?
    var createdAt : String?
    var updatedAt : String?
    
    init(rawJson:Any) {
        let json  = JSON(rawJson)
        id        = json["id"].intValue
        user_id   = json["user_id"].intValue
        content   = json["content"].stringValue
        location  = json["location"].stringValue
        imageUrl  = URL(string: json["imageUrl"].stringValue)!
        latitude  = json["latitude"].floatValue
        longitude = json["longitude"].floatValue
        like      = json["like"].intValue
        shared    = json["shared"].boolValue
        createdAt = json["createdAt"].stringValue
        updatedAt = json["updatedAt"].stringValue
    }
}
