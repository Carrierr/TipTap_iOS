//
//  TTRegisterViewModel.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 05/02/2019.
//  Copyright © 2019 Tiptap. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TTRegisterViewModel {
    //input
    let emailInputText  = BehaviorSubject(value: "")
    let authInputText   = BehaviorSubject(value: "")
    let didTapRequestAuth = PublishSubject<String>()
    let didTapAuth              = PublishSubject<Void>()
    
    //ouput
    var requestAuth    : Observable<String>?
    var auth                 : Observable<String>?
    let emailValid         = BehaviorSubject(value: false)
    
    
    let disposeBag = DisposeBag()
    let service         = TTRegisterService()
    init() {
        setup()
    }
    
    func setup(){
        emailInputText
            .filter{ $0 != "" }
            .map(checkEmailValid)
            .bind(to: emailValid)
            .disposed(by: disposeBag)
        
        
        requestAuth = didTapRequestAuth.flatMapLatest{ email in
            self.service.rxRequestEmailAuth(requestMail: email)
            }
        

        auth = didTapAuth.withLatesFrom(other1: emailInputText, other2: authInputText, selector: {($1,$2)})
            .flatMapLatest{s1,s2 in
                self.service.rxAuthEmail(requestMail: s1, authNumber: s2)
            }
    }
    
    
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}

