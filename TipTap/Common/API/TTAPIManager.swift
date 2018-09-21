//
//  TTAPIManager.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 11..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TTAPIManager {
    static let API_URL = "http://13.209.117.190:8080"
    static var sharedManager = TTAPIManager()
    

    func requestAPI( _ url: URLConvertible,
                     method: HTTPMethod = .get,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = ["tiptap-token":TTDeviceInfo.UserInfo.token],
                     completion: @escaping (Dictionary<String, Any>) -> ()){
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (result) in
            guard let resultValue = result.result.value else {
                print("========통신 오류========")
                return
            }
            
            let jsonResult = JSON(resultValue)
            guard let jsonDictionary = jsonResult.dictionary else { return }
            
            completion(jsonDictionary)
        }
    }
}
