//
//  TTTermsOfServiceViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 25/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit

class TTTermsOfServiceViewController:TTBaseViewController {
    @IBOutlet weak var contentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func setupUI() {
        
        /*
         let style = NSMutableParagraphStyle()
         style.lineSpacing = 20
         let attributes = [NSParagraphStyleAttributeName : style]
         textView.attributedText = NSAttributedString(string: txtString, attributes: attributes)
         */
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        contentTextView.attributedText = NSAttributedString(string: contentTextView.text, attributes: attributes)
        
        navigationController?.navigationBar.tintColor = UIColor.black;
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.topItem?.title = "";
        
        self.title = "이용약관"
    }

}
