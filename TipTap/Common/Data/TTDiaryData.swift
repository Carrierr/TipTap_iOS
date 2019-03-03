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
    var dataSet : TTDiaryDataSet? { get set }
}

struct TTDiaryDataSet {
    var diaryDataList     : [TTDiaryData]?
    var stampNameList : [String]?
    var result                  : Bool = false
    var resultCode          : Int   = 0
    
    init(diaryDataList : [TTDiaryData], stampNameList:[String]) {
        self.diaryDataList = diaryDataList
        self.stampNameList = stampNameList
    }
    
    
    init(rawJson : Any) {
        let json = JSON(rawJson)
        resultCode = json["code"].intValue
        guard resultCode == 1000 else { return }
        let dataDict = json["data"].dictionaryValue
        let dataJson = JSON(dataDict)
        
        guard let listDatas = dataJson["list"].array else { return }
        result = true
        diaryDataList = Array<TTDiaryData>()
        
        for diaryData in listDatas {
            diaryDataList?.append(TTDiaryData(rawJson:diaryData))
        }
        
        guard let stampDatas = dataJson["stamp"].array else { return }
        stampNameList = Array<String>()
        for stampStr in stampDatas {
            stampNameList?.append(stampStr.stringValue)
        }
    }
}

struct TTDiaryData {
    var id         : Int?
    var user_id    : Int?
    var content    : String?
    var location   : String?
    var imageUrl   : URL?
    var latitude   : Float?
    var longitude  : Float?
    var like       : Int?
    var shared     : Bool?
    var createdAt  : String?
    var updatedAt  : String?
    var createDate : String?
    var createTime : String?
    var city       : String?
    
    
    init(rawJson:Any) {
        let json  = JSON(rawJson)
        id        = json["id"].intValue
        user_id   = json["user_id"].intValue
        content   = json["content"].stringValue
        location  = json["location"].stringValue
        city      = json["city"].stringValue
        if let url = URL(string: json["imageUrl"].stringValue){
            imageUrl = url
        }
        latitude  = json["latitude"].floatValue
        longitude = json["longitude"].floatValue
        like      = json["like"].intValue
        shared    = json["shared"].boolValue
        let nsStr = json["createdAt"].stringValue as NSString
        let range = nsStr.range(of: "T")
        createdAt = nsStr.substring(to: range.location)
        let nsStr2 = json["updatedAt"].stringValue as NSString
        let range2 = nsStr2.range(of: "T")
        updatedAt = nsStr.substring(to: range2.location)
        
        
        
        
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let myDate = dateFormatter.date(from: json["createdAt"].stringValue)
        
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone.local
        createDate = dateFormatter.string(from: myDate!)
        dateFormatter.dateFormat = "HH:mm"
        createTime = dateFormatter.string(from: myDate!)
    }
}
