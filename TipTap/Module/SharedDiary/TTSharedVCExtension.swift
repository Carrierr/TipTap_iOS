//
//  TTSharedVCExtension.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import ScratchCard

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
        
        if scratchPercent > 0.4 {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.scratchView.alpha = 0
            }) { (result) in
                if let count = self.moduleDatas?.diaryDataList?.count {
                    self.setupSharedDiaryNavigation(diaryCount: count,buttonHidden : false)
                }else{
                    self.setupSharedDiaryNavigation(diaryCount : 0, buttonHidden : true)
                }
                
                NotificationCenter.default.post(name: Notification.Name.ablePaging.changedAblePaging, object: nil)
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
