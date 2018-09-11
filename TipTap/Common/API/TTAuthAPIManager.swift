//
//  TTAuthAPIManager.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 11..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import Alamofire

enum TTAuthLoginPlatformType : String {
    case kakao = "kakao"
}

class TTAuthAPIManager: TTAPIManager {
    let auth_url = "\(API_URL)/auth"
    static let sharedManager = TTAuthAPIManager()
    let headers = [
        "charset":"utf-8",
        "Content-Type": "application/json"
    ]
    
    func login(loginFlatform : TTAuthLoginPlatformType ,
               account : String,
               name : String,
               completion: @escaping (TTResult<Bool>) -> ())  {
        
        let param : Parameters = [
            "type":loginFlatform.rawValue,
            "account":"wjdgo813@naver.com",
            "name":name
        ]
        
        Alamofire.request("\(auth_url)/login",
            method:.post,
            parameters:param,
            headers : headers).validate(statusCode : 200..<300).responseJSON { (response) in
                
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
