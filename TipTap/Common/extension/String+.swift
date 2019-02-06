//
//  UIString+.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

extension String{
    static let blockUser              = "신고 누적으로 서비스 이용이 제한되었습니다."
    static let errorString             = "알 수 없는 오류가 발생하였습니다. 잠시후에 다시 시도해주세요."
    static let emptySharedDiary = "아직 도착한 tiptap이 없어요."
    
    //auth
    static let successSendEmailAuth = "Email로 전송하였습니다. 인증번호를 확인해 주세요."
    static let successEmailAuth = "Email 인증이 완료되었습니다."
    static let failedEmailAuth     = "Email 인증이 실패하였습니다. 다시 시도해주세요."
    static let failedEmailAuthWrongNumber     = "Email 인증번호가 맞지 않습니다."
    static let failedSendEmailAuth     = "Email 인증번호 전송에 실패하였습니다. 다시 시도해주세요."
}
