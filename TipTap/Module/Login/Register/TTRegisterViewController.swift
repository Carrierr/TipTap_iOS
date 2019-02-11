//
//  TTRegisterViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 05/02/2019.
//  Copyright © 2019 Tiptap. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TTRegisterViewController: TTBaseViewController, TTCanShowAlert {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var authNumberTextField: UITextField!
    
    @IBOutlet private weak var emailWarnLabel: UILabel!
    @IBOutlet private weak var authWarnLabel: UILabel!
    
    @IBOutlet private weak var requestAuthButton: UIButton!
    @IBOutlet private weak var authButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel   = TTRegisterViewModel()
    
    var disposeBag : DisposeBag  {
        return viewModel.disposeBag
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func setupUI() {
        self.registerButton.isEnabled = false
        self.emailWarnLabel.isHidden = true
        self.authWarnLabel.isHidden  = true
        self.registerButton.layer.borderColor = UIColor.gray.cgColor
        self.registerButton.layer.borderWidth = 1
        
        self.requestAuthButton.layer.borderColor = UIColor.gray.cgColor
        self.requestAuthButton.layer.borderWidth = 1
        
        self.authButton.layer.borderColor = UIColor.gray.cgColor
        self.authButton.layer.borderWidth = 1
        
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
            .bind(to:viewModel.emailInputText)
            .disposed(by: disposeBag)
        
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to:viewModel.passWordInputText)
            .disposed(by:disposeBag)
        
        
        self.nicknameTextField.rx.text.orEmpty
            .bind(to:viewModel.nickNameInputText)
            .disposed(by:disposeBag)
        
        
        self.authNumberTextField.rx.text.orEmpty
            .bind(to:viewModel.authInputText)
            .disposed(by: disposeBag)
        
        
        self.requestAuthButton.rx
            .tap
            .map{ self.emailTextField.text ?? "" }
            .filter{ $0 != "" }
            .bind(to:viewModel.didTapRequestAuth)
            .disposed(by: disposeBag)
        
        
        self.authButton.rx
            .tap
            .bind(to: viewModel.didTapAuth)
            .disposed(by:disposeBag)

        
        
        self.registerButton.rx
            .tap
            .bind(to:viewModel.didTapRegister)
            .disposed(by:disposeBag)

    }
    
    
    private func bindOutput(){
        self.viewModel.emailValid
            .subscribe(onNext:{ [weak self ]result in
                if !result{
                    self?.emailWarnLabel.text = "E-mail을 올바르게 입력해주세요."
                    self?.emailWarnLabel.isHidden = false
                    self?.requestAuthButton.isEnabled = false
                }else{
                    self?.emailWarnLabel.isHidden = true
                    self?.requestAuthButton.isEnabled = true
                }
            }).disposed(by:disposeBag)
        
        
        
        self.viewModel.requestAuth?.drive(onNext: { message in
            self.showAlert(title: "알림", message: message)
        }).disposed(by: disposeBag)
        
        
        
        self.viewModel.requestAuthError
            .asDriver(onErrorJustReturn: AuthApiError.error(""))
            .drive(onNext: { error in
                var errorString = ""
                switch error {
                case .error(let errorMessage):
                    errorString = errorMessage
                    break
                }
                
                self.emailWarnLabel.isHidden = false
                self.emailWarnLabel.text = errorString
            }).disposed(by: disposeBag)
        
        
        
        self.viewModel.auth?.drive(onNext: { string in
            self.authWarnLabel.isHidden = true
            self.showAlert(title: "알림", message: string)
        }).disposed(by: disposeBag)
        
        
        
        self.viewModel.authError
            .asDriver(onErrorJustReturn: AuthApiError.error(""))
            .drive(onNext: { error in
                var errorString = ""
                switch error {
                case .error(let errorMessage):
                    errorString = errorMessage
                    break
                }
                
                self.authWarnLabel.isHidden = false
                self.authWarnLabel.text = errorString
            }).disposed(by: disposeBag)
        
        
        
        self.viewModel.register?.drive(onNext:{ message in
            self.showAlert(title: "알림", message: message, confirmButtonTitle: "확인", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }).disposed(by:disposeBag)
        
        
        
        self.viewModel.registerError
            .asDriver(onErrorJustReturn: AuthApiError.error(""))
            .drive(onNext:{ error in
                var errorString = ""
                switch error {
                case .error(let errorMessage):
                    errorString = errorMessage
                    break
                }
                
                self.showAlert(title: "알림", message: errorString)
            }).disposed(by: disposeBag)
        
        
        
        
        Observable.combineLatest(
            self.viewModel.emailValid,
            self.emailTextField.rx.text.orEmpty.map{($0.count > 0)},
            self.passwordTextField.rx.text.orEmpty.map{($0.count > 0)},
            self.nicknameTextField.rx.text.orEmpty.map{($0.count > 0)},
            self.authNumberTextField.rx.text.orEmpty.map{($0.count > 0)},
            self.authWarnLabel.rx.observe(Bool.self, "hidden").map{($0!)}
            , resultSelector : { $0 && $1 && $2 && $3 && $4 && $5
                
        }).subscribe(onNext: { result in
            self.registerButton.isEnabled = result
        }).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
