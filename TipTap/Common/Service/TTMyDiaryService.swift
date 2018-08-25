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
    private var myDiaryData : [[String:String]]?
    
    func fetchMyDiaryList(completion: @escaping (TTResult<[[String:String]]>) -> ()){
        let resultDict : [String:String] = ["day":"22",
                                          "start":"낙성대역",
                                          "destination":"서울 특별시 망원동 키오스크"
        ]
        
        let resultDict2 : [String:String] = ["day":"24",
                                            "start":"서울 특별시 이태원역",
                                            "destination":"인천 동구 송현동 솔빛마을"
        ]
        
        let resultDict3 : [String:String] = ["day":"21",
                                            "start":"부산광역시 해운대",
                                            "destination":"대구 망원동 스타벅스"
        ]
        
        let resultDict4 : [String:String] = ["day":"17",
                                            "start":"낙성대역",
                                            "destination":"조선민주주의인민공화국"
        ]
        
        myDiaryData = [resultDict,resultDict2,resultDict3,resultDict4]
        completion(.success(myDiaryData!))

    }
}
