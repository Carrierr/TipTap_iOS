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
    var diaryDataList : [TTDiaryData]?
    var stampNameList : [String]?
    var result        : Bool = false
    
    init(diaryDataList : [TTDiaryData], stampNameList:[String]) {
        self.diaryDataList = diaryDataList
        self.stampNameList = stampNameList
    }
    
    
    init(rawJson : Any) {
        let json = JSON(rawJson)
        guard json["code"].intValue == 1000 else { return }
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
        if let url = URL(string: json["imageUrl"].stringValue){
            imageUrl = url
        }
        latitude  = json["latitude"].floatValue
        longitude = json["longitude"].floatValue
        like      = json["like"].intValue
        shared    = json["shared"].boolValue
        createdAt = json["createdAt"].stringValue
        updatedAt = json["updatedAt"].stringValue
    }
}
