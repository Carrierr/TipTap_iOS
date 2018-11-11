//
//  TTMyDiaryService.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SwiftyJSON

class TTDetailDiaryService{
    private let URL = ""
    private var myDiaryData : [String]?
    
    func fetchDetailDiaryList(dateString : String,
        completion: @escaping (TTResult<[TTDiaryData]>) -> ()){
        ///diary/detail?date=2018-09-26
        
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/detail?date=\(dateString)", method: .get) { (result) in
            print("result : \(result)")
            let resultData = TTDiaryDataSet(rawJson: result)
            guard let dataList = resultData.diaryDataList else { return }
                
            completion(.success(dataList))
        }
    }
    
    
    func fetchDeleteDiary(deleteDate : String,
                          completion: @escaping (TTResult<Int>) -> ()){
        let param = ["date":deleteDate]
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/delete/day", method: .post,parameters: param) { (result) in
            let json = JSON(result)
            if json["code"].intValue == 1000 {
                completion(.success(1))
            }
            print("myDiary interval result : \(result)")
        }
    }
    
    func fetchDeleteDiary(deleteID : String,
                          completion: @escaping (TTResult<Int>) -> ()){
        let param = ["id":[deleteID]]
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/delete", method: .post,parameters: param) { (result) in
            let json = JSON(result)
            if json["code"].intValue == 1000 {
                completion(.success(1))
            }else{
                completion(.errorMessage("알 수 없는 오류가 발생했습니다. 잠시후에 다시 시도해주세요."))
            }
            print("myDiary interval result : \(result)")
        }
    }
}
