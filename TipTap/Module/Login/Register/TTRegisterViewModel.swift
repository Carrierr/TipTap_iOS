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
    let authNumberValid = BehaviorSubject(value: false)
    
    
    let disposeBag = DisposeBag()
    let service         = TTRegisterService()
    
    
    init() {
        setup()
    }
    
    private func setup(){
        emailInputText
            .filter{ $0 != "" }
            .map(checkEmailValid)
            .bind(to: emailValid)
            .disposed(by: disposeBag)
        
        authInputText
            .filter{ $0 != "" }
            .map{ _ in true }
            .bind(to: authNumberValid)
            .disposed(by: disposeBag)
        
        
        requestAuth = didTapRequestAuth.flatMapLatest{ email in
            self.service.rxRequestEmailAuth(requestMail: email)
            }
        
        
        let authValidations = Observable.combineLatest(emailValid,authNumberValid,resultSelector:{ $0 && $1 })
        let text                    = Observable.combineLatest(emailInputText, authInputText) { ($0,$1)}

           auth = didTapAuth
            .withLatestFrom(authValidations)
            .filter{ $0 }
            .withLatestFrom(text)
            .flatMapLatest{
            self.service.rxAuthEmail(requestMail: $0, authNumber: $1)
                
        }
    }
    
    
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}

