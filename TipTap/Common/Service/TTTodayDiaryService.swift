//
//  TTTodayDiaryService.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 23..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

struct TTTodayDiaryService {
    func fetchTodayDiary(
        completion: @escaping (TTResult<TTDiaryDataSet>) -> ()
        ){
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/today", method: .get) { (result) in
            print("result : \(result)")
            let resultData = TTDiaryDataSet(rawJson: result)
            guard resultData.result else {
                completion(.errorMessage(String.errorString))
                return
            }
            completion(.success(resultData))
        }
    }
}
