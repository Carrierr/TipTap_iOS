//
//  TTMyDiaryService.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

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
}
