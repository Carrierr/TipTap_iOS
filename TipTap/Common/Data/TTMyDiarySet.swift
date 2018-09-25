//
//  TTMyDiarySet.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 26..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TTMyDiarySet {
    var totalPage    : Int?
    var myDiaryDatas : [TTMyDiaryMonthData]?
    
    init(rawJson : Any) {
        let json = JSON(rawJson)
        guard json["code"].intValue == 1000 else { return }
        let dataDict = json["data"].dictionaryValue
        let dataJson = JSON(dataDict)
        
        totalPage    = dataJson["total"].intValue
        myDiaryDatas = [TTMyDiaryMonthData]()
        
        for monthData in dataJson["list"].arrayValue {
            myDiaryDatas?.append(TTMyDiaryMonthData(rawJson:monthData))
        }
        
    }
}

struct TTMyDiaryMonthData {
    var year  : String?
    var month : String?
    var myDateDatas : [TTMyDiaryDayData]?
    
    init(rawJson : Any) {
        let json = JSON(rawJson)
        year  = json["year"].stringValue
        month = json["month"].stringValue
        myDateDatas = [TTMyDiaryDayData]()
        
        for dateData in json["datas"].arrayValue {
            myDateDatas?.append(TTMyDiaryDayData(rawJson: dateData))
        }
    }
}

/*
 /**** api 협의 사항 ****/
 firstDiary가 없고
 lastDiary만 있는 경우는 해당 일의 일기가 1개 밖에 없는 것.
 */
struct TTMyDiaryDayData {
    var day : String?
    var lastDiary  : TTDiaryData?
    var firstDiary : TTDiaryData?
    
    init(rawJson : Any) {
        let json = JSON(rawJson)
        day = json["day"].stringValue
        let dataDict = json["diaryDatas"].dictionaryValue
        let dataJson = JSON(dataDict)
        if let firstDiaryData = dataJson["firstDiary"].dictionary{
            firstDiary = TTDiaryData(rawJson: firstDiaryData)
        }
        
        if let lastDiaryData = dataJson["lastDiary"].dictionary{
            lastDiary = TTDiaryData(rawJson: lastDiaryData)
        }
    }
}
