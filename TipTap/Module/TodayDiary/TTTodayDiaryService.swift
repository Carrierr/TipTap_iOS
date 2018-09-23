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
            completion(.success(TTDiaryDataSet(rawJson: result)))
        }
    }
}
