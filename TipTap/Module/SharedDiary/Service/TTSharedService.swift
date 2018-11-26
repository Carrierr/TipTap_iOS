//
//  TTSharedService.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 11..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation


class TTSharedService {
    func fetchSharedDiaryList(completion: @escaping (TTResult<TTDiaryDataSet>) -> ()){
        
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/random", method: .get) { (result) in
            print("result : \(result)")
            let resultData = TTDiaryDataSet(rawJson: result)
            if resultData.resultCode == 9000 {
                //빈 데이터
                completion(.success(resultData))
                return
            }
            
            guard let count = resultData.diaryDataList?.count else {
                completion(.errorMessage(String.errorString))
                return
            }
            
            guard count > 0 else {
                completion(.errorMessage(String.errorString))
                return
            }
            
            completion(.success(resultData))
        }
    }
}
