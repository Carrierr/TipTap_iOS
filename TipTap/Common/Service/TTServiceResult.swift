//
//  TTServiceResult.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

enum TTResult<T>{
    case success(T)
    case error(Error)
    case errorMessage(String)
}

enum TTServiceError:Error{
    case unknwon
    case requestFailed(response:URLResponse,data:Data?)
}


enum AuthApiError: Error {
    case error(String)              //Status code 403
}

enum RegisterResult<T>{
    case Success(T)
    case Failure(AuthApiError)
}
