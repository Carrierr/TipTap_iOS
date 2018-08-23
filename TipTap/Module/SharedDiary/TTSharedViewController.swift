//
//  TTSharedViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import Darwin

import ScratchCard


class TTSharedViewController: UIViewController {
    
    var scratchView : ScratchUIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        attachScratchView()
    }

    func attachScratchView(){
        //Coupon : 지우고 나서의 원본 이미지
        //MaskImage : 지울 이미지
        
        let randomNumber = arc4random_uniform(3) + 1
        
        scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),
                                     Coupon: self.view.asImage(),
                                     MaskImage: "scratch0\(randomNumber).png",
                                     ScratchWidth: CGFloat(40))
        scratchView.delegate = self
        self.view.addSubview(scratchView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


