//
//  TTDescriptContentViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 10. 31..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTDescriptContentViewController: UIViewController {
    var descriptionContent  : String?
    var descriptionTitle    : String?
    var descriptionImage: UIImage?
    
    @IBOutlet private weak var imageHeightConst: NSLayoutConstraint!
    @IBOutlet private weak var splashImageView: UIImageView!
    @IBOutlet private weak var descriptTitleLabel: UILabel!
    @IBOutlet private weak var descriptContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptTitleLabel.text = descriptionTitle
        descriptContentLabel.text = descriptionContent
        splashImageView.image     = descriptionImage
        imageHeightConst.constant = UIScreen.main.bounds.height * 0.6
    }
}
