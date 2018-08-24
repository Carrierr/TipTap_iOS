//
//  TTTodayDiaryViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTTodayDiaryViewController: TTBaseViewController {
    @IBOutlet weak var postView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let postView = Bundle.main.loadNibNamed("TTPostView", owner: self, options: nil)?[0] as? UIView {
//            self.postView.addSubview(postView)
//        }
        let tempView = TTPostTempView(frame: self.view.frame)
        self.postView.addSubview(tempView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
