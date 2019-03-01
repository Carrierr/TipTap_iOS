//
//  TTLoginViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTFirstViewController: TTBaseViewController {

    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
    }
    
    
    override func setupUI() {
        self.titleLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        self.loginButton.layer.borderColor = UIColor.gray.cgColor
        self.loginButton.layer.borderWidth = 1
        
        self.registerButton.layer.borderColor = UIColor.gray.cgColor
        self.registerButton.layer.borderWidth = 1
    }
    
    
    private func initNavi(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
