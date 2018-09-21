//
//  TTAuthAPIManager.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 11..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum TTAuthLoginPlatformType : String {
    case kakao = "kakao"
}

class TTAuthAPIManager {
    static var sharedManager = TTAuthAPIManager()
    let auth_url = "\(TTAPIManager.API_URL)/auth"
    
    func login(loginFlatform : TTAuthLoginPlatformType = .kakao,
               account : String,
               name : String,
               completion: @escaping (TTResult<Bool>) -> ())  {
        
        let param : Parameters = [
            "type":loginFlatform.rawValue,
            "account":account,
            "name":name
        ]
        
        Alamofire.request("\(auth_url)/login", method: .post, parameters: param).responseJSON { (result) in
            guard let resultValue = result.result.value else {
                completion(.errorMessage("알 수 없는 오류가 발생하였습니다. 잠시 후에 다시 시도해주세요. "))
                return
            }
            
            let jsonResult = JSON(resultValue)
            
            switch result.result {
            case .success:
                TTDeviceInfo.UserInfo.token    = jsonResult["data"]["token"].stringValue
                TTDeviceInfo.UserInfo.nickName = name
                TTDeviceInfo.UserInfo.userID   = account
                completion(.success(true))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
