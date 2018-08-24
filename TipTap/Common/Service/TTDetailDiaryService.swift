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
    
    func fetchDetailDiaryList(completion: @escaping (TTResult<[String]>) -> ()){
        myDiaryData = ["a","b","c","d"]
        completion(.success(myDiaryData!))
//        completion(.error(error!))
//        completion(.errorMessage("error"))
    }
}
