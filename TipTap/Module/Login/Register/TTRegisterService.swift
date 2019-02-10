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
    func rxRequestEmailAuth(requestMail : String)->Observable<RegisterResult<String>>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                TTAuthAPIManager.sharedManager.requestAuthAPI("\(TTAPIManager.API_URL)/auth/send/mail", parameters: ["mail":requestMail], completion: { (result) in
                    print("result : \(result)")
                    let result = JSON(result)
                    
                    guard result["code"].intValue == 1000 else {
                            seal.onError(AuthApiError.error)
                            return
                    }
                    seal.onNext(.Success(String.successSendEmailAuth))
                    seal.onCompleted()
                })
            }
            return Disposables.create()
        }
    }
    
    
    func rxAuthEmail(requestMail : String, authNumber : String)->Observable<RegisterResult<String>>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                print("tap auth email")
                TTAuthAPIManager.sharedManager.requestAuthAPI("\(TTAPIManager.API_URL)/auth/mail", parameters: ["mail":requestMail,"auth":authNumber], completion: { (result) in
                    print("result : \(result)")
                    let result = JSON(result)
                    
                    guard result["code"].intValue == 1000 else {
                        let errorCode = result["code"].intValue
                        
                        if errorCode == 5000{
                            seal.onError(AuthApiError.errorNumber)
                        }else{
                            seal.onError(AuthApiError.error)
                        }
                        
                        return
                    }
                    seal.onNext(.Success(String.successEmailAuth))
                    seal.onCompleted()
                })
            }
            return Disposables.create()
        }
    }
}
