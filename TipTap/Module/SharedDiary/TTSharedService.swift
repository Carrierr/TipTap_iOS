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
            guard let count = resultData.diaryDataList?.count else {
                completion(.errorMessage("알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요."))
                return
            }
            guard count > 0 else {
                completion(.errorMessage("알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요."))
                return
            }
            
            completion(.success(resultData))
        }
    }
}
