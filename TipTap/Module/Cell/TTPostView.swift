//
//  TTPostView.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import SnapKit


class TTPostView: UIView {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var tipTapLabel: UILabel!
    @IBOutlet weak var diaryCountLabel: UILabel!
    
    @IBOutlet weak var postImage2: UIImageView!
    @IBOutlet weak var postImage1: UIImageView!
    
    var onTouchedSecondPostView: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tipTapLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
    }

    
    
    
    @IBAction func pressedFirstPost(_ sender: Any) {
        
    }
    @IBAction func touchDownFirstPost(_ sender: Any) {
        
    }
    
    @IBAction func pressedSecondPost(_ sender: Any) {
        postImage2.image = UIImage(named: "post2")
        guard onTouchedSecondPostView != nil else {
            return
        }
        
        onTouchedSecondPostView!()
    }
    @IBAction func touchDownSecondPost(_ sender: Any) {
        postImage2.image = UIImage(named: "pressedPost2")
    }
}
