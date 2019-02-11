//
//  TTLoginViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 12/02/2019.
//  Copyright © 2019 Tiptap. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftyJSON


class TTLoginViewController: TTBaseViewController,TTCanShowAlert {

    
    @IBOutlet private weak var emailTextField   : UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton      : UIButton!
    
    //input
    private let emailInputText    = BehaviorSubject(value: "")
    private let passwordInputText = BehaviorSubject(value: "")
    
    
    private let disposeBag = DisposeBag()
    
    override func setupUI() {
        self.loginButton.isEnabled = false
        self.loginButton.layer.borderColor = UIColor.gray.cgColor
        self.loginButton.layer.borderWidth = 1
        
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.topItem?.title = "";
    }
    
    
    
    override func setupBinding() {
        bindInput()
        bindOutput()
    }
    
    
    
    private func bindInput(){
        self.emailTextField.rx.text.orEmpty
            .bind(to:self.emailInputText)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to:self.passwordInputText)
            .disposed(by: self.disposeBag)
    }
    
    
    
    private func bindOutput(){
        Observable.combineLatest(
            self.emailInputText.map{ ($0.count > 0) },
            self.passwordInputText.map{ ($0.count > 0) }
            , resultSelector: { $0 && $1})
            .subscribe(onNext:{ result in
                self.loginButton.isEnabled = result
            }).disposed(by: disposeBag)
        
        
        
        let loginRequiredText = Observable.combineLatest(
            self.emailInputText,
            self.passwordInputText){ ($0,$1) }
        
        
        
        let loginError = PublishSubject<AuthApiError>()
        
        
        
        self.loginButton.rx.tap
            .withLatestFrom(loginRequiredText)
            .flatMapLatest{
                self.rxRequestLogin(email: $0, password: $1)
                    .do(onError:{ error in
                        loginError.onNext(error as? AuthApiError ?? AuthApiError.error(String.errorString))
                    })
                    .suppressError()
            }.asDriver(onErrorJustReturn: "")
            .drive(onNext:{ result in
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sessionDidChange"), object: nil)
            }).disposed(by: disposeBag)
        
        
        
        loginError.asDriver(onErrorJustReturn: AuthApiError.error(String.errorString))
            .drive(onNext:{ error in
                var errorString = ""
                switch error {
                case .error(let errorMessage):
                    errorString = errorMessage
                    break
                }
                
                self.showAlert(title: "오류", message: errorString)
            }).disposed(by: disposeBag)
    }
}

extension TTLoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    private func rxRequestLogin(email:String,
                                password:String) -> Observable<String>{
        return Observable.create{ seal in
            DispatchQueue.global().async {
                TTAuthAPIManager.sharedManager.login(loginFlatform: .email,
                                                     account: email,
                                                     password: password,
                                                     completion: { (result) in
                                                        switch result {
                                                        case .success( _):
                                                            seal.onNext(String.successSendEmailAuth)
                                                            seal.onCompleted()
                                                            break
                                                            
                                                        case .error(let error):
                                                            seal.onError(error)
                                                            break
                                                            
                                                        case .errorMessage(let errorMessage):
                                                            seal.onError(AuthApiError.error(errorMessage))
                                                            break
                                                        }
                })
            }
            return Disposables.create()
        }

    }
}
