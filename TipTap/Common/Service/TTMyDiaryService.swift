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
    private var myDiaryData : [String]?
    
    func fetchMyDiaryList(completion: @escaping (TTResult<[String]>) -> ()){
        myDiaryData = ["a","b","c"]
        completion(.success(myDiaryData!))
//        completion(.error(error!))
//        completion(.errorMessage("error"))
    }
}
