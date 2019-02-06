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

class TTAuthAPIManager : TTCanShowAlert{
    static var sharedManager = TTAuthAPIManager()
    let auth_url = "\(TTAPIManager.API_URL)/auth/"
    
    func login(loginFlatform : TTAuthLoginPlatformType = .kakao,
               account : String,
               name : String,
               completion: @escaping (TTResult<Bool>) -> ())  {
        
        let param : Parameters = [
            "type":loginFlatform.rawValue,
            "account":account,
            "name":name
        ]
        
        Alamofire.request("\(auth_url)login", method: .post, parameters: param).responseJSON { (result) in
            guard let resultValue = result.result.value else {
                completion(.errorMessage(String.errorString))
                return
            }
            
            let jsonResult = JSON(resultValue)
            print("login Result : \(resultValue)")
            switch result.result {
            case .success:
                UserInfo.token    = jsonResult["data"]["token"].stringValue
                UserInfo.nickName = name
                UserInfo.userID   = account
                completion(.success(true))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    
    func requestAuthAPI( _ url: URLConvertible,
                     parameters: Parameters? = nil,
        completion: @escaping (Dictionary<String, Any>) -> ()){
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (result) in
            appDelegate?.hideLoadingView()
            guard let resultValue = result.result.value else {
                print("========통신 오류========")
                self.showAlert(title: "", message:  String.errorString)
                return
            }
            
            let jsonResult = JSON(resultValue)
            guard let jsonDictionary = jsonResult.dictionary else {
                print("========통신 오류========")
                self.showAlert(title: "", message:  String.errorString)
                return
            }
            
            completion(jsonDictionary)
        }
    }
}
