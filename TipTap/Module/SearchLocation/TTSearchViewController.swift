//
//  TTSearchViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 02/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TTSearchViewController: TTBaseViewController  {

    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getLocations(withKeyword: "스타벅스")
    }
    
    override func setupUI(){
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        
        searchTableView.separatorStyle = .none
    }
    
    override func setupBinding() {
//        let bag = DisposeBag()
//        searchTextField.rx.text
//            .orEmpty
//            .debounce(0.5,scheduler:MainScheduler.instance)
//            .bind{_ in
//            print("textFiels : \(self.searchTextField.text!)")
//        }.disposed(by: bag)
//
//
//
//         searchTextField.rx.controlEvent(.editingChanged).asObservable().subscribe(onNext: { [unowned self] character in
//                        print("textFiels : \(self.searchTextField.text!)")
//                        print("textFiels : \(character)")
//        }).disposed(by: bag)

        
        
    }
}

extension TTSearchViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        searchTextField.sendActions(for: .editingChanged)
        return true
        
    }
    
}



