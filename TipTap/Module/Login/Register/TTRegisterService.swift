//
//  TTRegisterService.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 06/02/2019.
//  Copyright © 2019 Tiptap. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift



class TTRegisterService {
    func rxRequestEmailAuth(requestMail : String)->Observable<String>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                TTAuthAPIManager.sharedManager.requestAuthAPI("\(TTAPIManager.API_URL)/auth/send/mail", parameters: ["mail":requestMail], completion: { (result) in
                    print("result : \(result)")
                    let result = JSON(result)
                    
                    guard result["code"].intValue == 1000 else {
                        let errorMessage = result["data"]["message"].stringValue
                        seal.onError(AuthApiError.error(errorMessage))
                        return
                    }
                    seal.onNext(String.successSendEmailAuth)
                    seal.onCompleted()
                })
            }
            return Disposables.create()
        }
    }
    
    
    func rxAuthEmail(requestMail : String, authNumber : String)->Observable<String>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                print("tap auth email")
                TTAuthAPIManager.sharedManager.requestAuthAPI("\(TTAPIManager.API_URL)/auth/mail", parameters: ["mail":requestMail,"auth":authNumber], completion: { (result) in
                    print("result : \(result)")
                    let result = JSON(result)
                    
                    guard result["code"].intValue == 1000 else {
                        let errorMessage = result["data"]["message"].stringValue
                        seal.onError(AuthApiError.error(errorMessage))
                        
                        return
                    }
                    seal.onNext(String.successEmailAuth)
                    seal.onCompleted()
                })
            }
            return Disposables.create()
        }
    }
    
    func rxRegisterUser(account : String,
                        nickName : String,
                        password : String
                        )->Observable<String>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                TTAuthAPIManager.sharedManager.requestAuthAPI("\(TTAPIManager.API_URL)/auth/sign/up/mail"
                    , parameters: ["account":account,
                                   "name":nickName,
                                   "password":password]
                    , completion: { (result) in
                    print("register result : \(result)")
                    let result = JSON(result)
                    
                    guard result["code"].intValue == 1000 else {
                        let errorMessage = result["data"]["message"].stringValue
                        
                        seal.onError(AuthApiError.error(errorMessage))
                        return
                    }
                    seal.onNext(String.successRegisterUser)
                    seal.onCompleted()
                })
            }
            return Disposables.create()
        }
    }
}
