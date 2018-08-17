//
//  TTMyDiaryViewController.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

protocol TTMyDiaryViewProtocol:class{
    func startNetworking()
    func stopNetworking()
}

class TTMyDiaryViewController: TTBaseViewController {

    var presenter:TTMyDiaryPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func setupUI() {
        
    }
    
    override func setupBinding() {
        
    }
    
}
