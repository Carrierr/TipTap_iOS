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
        emailTextField.rx.text.orEmpty
            .bind(to:viewModel.emailInputText)
            .disposed(by: disposeBag)
        
        
        authNumberTextField.rx.text.orEmpty
            .bind(to:viewModel.authInputText)
            .disposed(by: disposeBag)
        
        
        requestAuthButton.rx
            .tap
            .map{ self.emailTextField.text ?? "" }
            .filter{ $0 != "" }
            .bind(to:viewModel.didTapRequestAuth)
            .disposed(by: disposeBag)
        
        
        
        
        authButton.rx
            .tap
            .bind(to: viewModel.didTapAuth)
            .disposed(by:disposeBag)
    }
    
    
    private func bindOutput(){
        viewModel.emailValid
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
        
        
        viewModel.requestAuth?.subscribe(onNext: { [weak self] str in
            self?.showAlert(title: "알림", message: str)
            }, onError: { [weak self] (error) in
                self?.emailWarnLabel.isHidden = false
                self?.emailWarnLabel.text = String.failedSendEmailAuth
        }).disposed(by: disposeBag)
        
        
        viewModel.auth?.subscribe(onNext:{ [weak self] str in
            self?.showAlert(title: "알림", message: str)
            }, onError : { [weak self] error in
                
                var errorString = ""
                switch error{
                case AuthApiError.errorNumber:
                    errorString = String.failedEmailAuthWrongNumber
                    break
                default:
                    errorString = String.failedEmailAuth
                    break
                }
                
                self?.authWarnLabel.isHidden = false
                self?.authWarnLabel.text = errorString
        }).disposed(by: disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
