//
//  TTMyDiaryService.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

class TTMyDiaryService{
    private let URL = ""
    private var myDiaryData : TTMyDiarySet?
    //,headers:["tiptap-token":"5ddfcb4c-aff0-441b-9a88-e7dbecb43170"]
    func fetchMyDiaryList(completion: @escaping (TTResult<TTMyDiarySet>) -> ()){
        TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/list?page=1&limit=20", method: .get) { (result) in
            let myDiaryDatas : TTMyDiarySet = TTMyDiarySet(rawJson: result)
            
            completion(.success(myDiaryDatas))
        }
    }
}
