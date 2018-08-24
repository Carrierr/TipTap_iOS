//
//  TTBaseViewController.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupBinding()
        setupUI()
    }
    
    func initNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupUI(){
        //Override
    }
    
    func setupBinding(){
        //Override
    }
    
    deinit {
        
    }
}
