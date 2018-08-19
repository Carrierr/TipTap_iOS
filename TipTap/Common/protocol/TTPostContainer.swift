//
//  TTPostContainer.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SnapKit

protocol TTPostContainer where Self : UIView {
    var postImageView1      : UIImageView? { get set }
    var postImageView2      : UIImageView? { get set }
    var postImageView3      : UIImageView? { get set }
    var postImageView4      : UIImageView? { get set }
    var postImageView5      : UIImageView? { get set }
    var postImageView6      : UIImageView? { get set }
    var postImageView7      : UIImageView? { get set }
    var postImageView8      : UIImageView? { get set }
    var postImageView9      : UIImageView? { get set }
    var postImageView10     : UIImageView? { get set }
    
    func contentChanged()
}

extension TTPostContainer {
    func contentChanged(){
        guard
            let postImageView1 = postImageView1,
            let postImageView2 = postImageView2,
            let postImageView3 = postImageView3,
            let postImageView4 = postImageView4,
            let postImageView5 = postImageView5,
            let postImageView6 = postImageView6,
            let postImageView7 = postImageView7,
            let postImageView8 = postImageView8,
            let postImageView9 = postImageView9,
            let postImageView10 = postImageView10 else {
                return
        }
        
        self.addSubview(postImageView1)
        self.addSubview(postImageView2)
        self.addSubview(postImageView3)
        self.addSubview(postImageView4)
        self.addSubview(postImageView5)
        self.addSubview(postImageView6)
        self.addSubview(postImageView7)
        self.addSubview(postImageView8)
        self.addSubview(postImageView9)
        self.addSubview(postImageView10)
        
        
        
        
    }
}
