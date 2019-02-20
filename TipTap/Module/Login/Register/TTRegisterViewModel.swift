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
    let emailInputText    = BehaviorSubject(value: "")
    let nickNameInputText = BehaviorSubject(value: "")
    let passWordInputText = BehaviorSubject(value: "")
    let authInputText     = BehaviorSubject(value: "")
    let didTapRequestAuth = PublishSubject<String>()
    let didTapAuth        = PublishSubject<Void>()
    let didTapRegister    = PublishSubject<Void>()
    
    //ouput
    var requestAuth      : Driver<String>?
    var auth             : Driver<String>?
    var register         : Driver<String>?
    
    let requestAuthError = PublishSubject<AuthApiError>()
    let authError        = PublishSubject<AuthApiError>()
    let registerError    = PublishSubject<AuthApiError>()
    
    let emailValid       = BehaviorSubject(value: false)
    let authNumberValid  = BehaviorSubject(value: false)
    var authRequiredValid  : Observable<Bool>?
    
    
    let disposeBag = DisposeBag()
    let service    = TTRegisterService()
    
    
    init() {
        setup()
    }
    
    private func setup(){
        self.emailInputText
            .filter{ $0 != "" }
            .map(checkEmailValid)
            .bind(to: emailValid)
            .disposed(by: disposeBag)
        
        
        self.authInputText
            .filter{ $0 != "" }
            .map{ _ in true }
            .bind(to: self.authNumberValid)
            .disposed(by: disposeBag)
        
        
        
        self.authRequiredValid = Observable.combineLatest(emailInputText.map{ $0.count > 0 }, authInputText.map{ $0.count > 0 }) { ($0 && $1) }
        
        
        
        self.requestAuth = didTapRequestAuth
            .flatMapLatest{ email in
                self.service.rxRequestEmailAuth(requestMail: email)
                    .do(onError : { error in
                        self.requestAuthError.onNext(error as! AuthApiError)
                    })
                    .suppressError()
            }.asDriver(onErrorJustReturn: "")
        
        
        
        let authValidations = Observable.combineLatest(emailValid,authNumberValid,resultSelector:{ $0 && $1 })
        let authRequiretext = Observable.combineLatest(emailInputText, authInputText) { ($0,$1) }
        
        self.auth = didTapAuth
            .withLatestFrom(authValidations)
            .filter{ $0 }
            .withLatestFrom(authRequiretext)
            .flatMapLatest{
                self.service.rxAuthEmail(requestMail: $0, authNumber: $1)
                    .do(onError:{ error in
                        self.authError.onNext(error as! AuthApiError)
                    })
                    .suppressError()
                
            }.asDriver(onErrorJustReturn: "")
        
        
        
        let registerRequireText = Observable.combineLatest(
            emailInputText,
            nickNameInputText,
            passWordInputText) { ($0,$1,$2) }
        
        
        
        self.register = didTapRegister
            .withLatestFrom(registerRequireText)
            .flatMapLatest{
                self.service.rxRegisterUser(account: $0, nickName: $1, password: $2)
                    .do(onError:{
                        self.registerError.onNext($0 as! AuthApiError)
                    })
                    .suppressError()
            }.asDriver(onErrorJustReturn:"")
    }
    
    
    
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}

