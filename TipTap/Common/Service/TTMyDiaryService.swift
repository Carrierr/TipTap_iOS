//
//  TTMyDiaryService.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SwiftyJSON

class TTMyDiaryService{
    private let URL = ""
    private var myDiaryData : TTMyDiarySet?
    //,headers:["tiptap-token":"5ddfcb4c-aff0-441b-9a88-e7dbecb43170"]
    func fetchMyDiaryList(completion: @escaping (TTResult<TTMyDiarySet>) -> ()){
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/list?page=1&limit=20", method: .get) { (result) in
            let myDiaryDatas : TTMyDiarySet = TTMyDiarySet(rawJson: result)
            print("myDiary result : \(result)")
            completion(.success(myDiaryDatas))
        }
    }
    
    //list/by/date?
    func fetchMyDiaryList(startDate : String, endDate: String, completion: @escaping (TTResult<TTMyDiarySet>) -> ()){
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/list/by/date?page=1&limit=20&startDate=\(startDate)&endDate=\(endDate)", method: .get) { (result) in
            let myDiaryDatas : TTMyDiarySet = TTMyDiarySet(rawJson: result)
            print("myDiary interval result : \(result)")
            completion(.success(myDiaryDatas))
        }
    }
    
    func fetchDeleteMyDiaryList(diaryItems:[String], completion: @escaping (TTResult<Int>) -> ()){
        let param = ["date":diaryItems]
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/delete/day", method: .post,parameters: param) { (result) in
            let json = JSON(result)
            if json["code"].intValue == 1000 {
                completion(.success(1))
            }
            print("myDiary interval result : \(result)")
        }
    }

}
