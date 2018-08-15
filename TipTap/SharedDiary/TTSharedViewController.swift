//
//  TTSharedViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import ScratchCard

class TTSharedViewController: UIViewController {
    
    var scratchView : ScratchUIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),Coupon: self.view.asImage(), MaskImage: "mask.png", ScratchWidth: CGFloat(40))
        scratchView.delegate = self
        self.view.addSubview(scratchView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




extension TTSharedViewController : ScratchUIViewDelegate {
    //Scratch Began Event(optional)
    func scratchBegan(_ view: ScratchUIView) {
        print("scratchBegan")
        
        let position = Int(view.scratchPosition.x).description + "," + Int(view.scratchPosition.y).description
        print(position)
        
    }
    
    //Scratch Moved Event(optional)
    func scratchMoved(_ view: ScratchUIView) {
        let scratchPercent: Double = self.scratchView.getScratchPercent()
        print("scratchPercent : \(scratchPercent)")

        ////Get the Scratch Position in ScratchCard(coordinate origin is at the lower left corner)
        let position = Int(view.scratchPosition.x).description + "," + Int(view.scratchPosition.y).description
        print(position)
        
        if scratchPercent > 0.1 {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.scratchView.alpha = 0
            }) { (result) in
                NotificationCenter.default.post(name: Notification.Name.IsAblePaging.changedAblePaging, object: nil)
            }
        }
    }
    
    //Scratch Ended Event(optional)
    func scratchEnded(_ view: ScratchUIView) {
        print("scratchEnded")
        
        ////Get the Scratch Position in ScratchCard(coordinate origin is at the lower left corner)
        let position = Int(view.scratchPosition.x).description + "," + Int(view.scratchPosition.y).description
        print(position)
    }
}
