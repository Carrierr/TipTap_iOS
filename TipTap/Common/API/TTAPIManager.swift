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

class TTAPIManager : TTCanShowAlert {
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
                self.showAlert(title: "", message: "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요.")
                return
            }
            
            let jsonResult = JSON(resultValue)
            guard let jsonDictionary = jsonResult.dictionary else { return }
            
            completion(jsonDictionary)
        }
    }
    
    func requestAPIWithImage( _ url: URLConvertible,
                              method: HTTPMethod = .post,
                              parameters: Parameters,
                              uploadImage : UIImage? = nil,
                              headers: HTTPHeaders? = ["tiptap-token":TTDeviceInfo.UserInfo.token],
                              completion: @escaping (Dictionary<String, Any>) -> ()){
        
        guard let imageData = uploadImage else {
            self.requestAPI(url, method: method, parameters: parameters, headers: headers, completion: completion)
            return
        }
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(imageData, 0.6) {
                    multipartFormData.append(imageData, withName: "diaryFile", fileName: "file.png",mimeType:"image/png")
                }
                
                for (key, value) in parameters {
                    if let dataStr = value as? String{
                        multipartFormData.append(dataStr.data(using: .utf8)!, withName: key)
                    }
                    
                }
                
        },
            to: url,
            headers:headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        guard let resultValue = response.result.value else {
                            print("========통신 오류========")
                            self.showAlert(title: "", message: "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요.")
                            return
                        }
                        
                        let jsonResult = JSON(resultValue)
                        guard let jsonDictionary = jsonResult.dictionary,
                        jsonResult["code"].intValue == 1000 else {
                            self.showAlert(title: "", message: "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요.")
                            return
                        }
                        completion(jsonDictionary)
                    }
                    upload.uploadProgress { progress in // main queue by default
                        print("Upload Progress: \(progress.fractionCompleted)")
                    }
                case .failure(let encodingError):
                    self.showAlert(title: "", message: "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요.")
                    print(encodingError)
                }
        }
        )
    }
}
