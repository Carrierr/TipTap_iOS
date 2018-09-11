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
    var postContainerView1      : UIView? { get set }
    var postContainerView2      : UIView? { get set }
    var postContainerView3      : UIView? { get set }
    var postContainerView4      : UIView? { get set }
    var postContainerView5      : UIView? { get set }
    var postContainerView6      : UIView? { get set }
    var postContainerView7      : UIView? { get set }
    var postContainerView8      : UIView? { get set }
    var postContainerView9      : UIView? { get set }
    var postContainerView10     : UIView? { get set }
    
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
    
    var postButton1      : UIButton? { get set }
    var postButton2      : UIButton? { get set }
    var postButton3      : UIButton? { get set }
    var postButton4      : UIButton? { get set }
    var postButton5      : UIButton? { get set }
    var postButton6      : UIButton? { get set }
    var postButton7      : UIButton? { get set }
    var postButton8      : UIButton? { get set }
    var postButton9      : UIButton? { get set }
    var postButton10     : UIButton? { get set }
    
    
    
    func contentChangedPost()
}

extension TTPostContainer {
    func contentChangedPost(){
        guard
            let _ = postContainerView1,
            let _ = postContainerView2,
            let _ = postContainerView3,
            let _ = postContainerView4,
            let _ = postContainerView5,
            let _ = postContainerView6,
            let _ = postContainerView7,
            let _ = postContainerView8,
            let _ = postContainerView9,
            let _ = postContainerView10 else {
                return
        }
        
        guard
            let _ = postButton1,
            let _ = postButton2,
            let _ = postButton3,
            let _ = postButton4,
            let _ = postButton5,
            let _ = postButton6,
            let _ = postButton7,
            let _ = postButton8,
            let _ = postButton9,
            let _ = postButton10 else {
                return
        }
        
        guard
            let _ = postImageView1,
            let _ = postImageView2,
            let _ = postImageView3,
            let _ = postImageView4,
            let _ = postImageView5,
            let _ = postImageView6,
            let _ = postImageView7,
            let _ = postImageView8,
            let _ = postImageView9,
            let _ = postImageView10 else {
                return
        }
        
        //addSubView
        addSubViews()

        setImage()
        setLabel()
        
        setPost1Constraint()
        setPost2Constraint()
        setPost3Constraint()
        setPost4Constraint()
        setPost5Constraint()
        setPost6Constraint()
        setPost7Constraint()
        setPost8Constraint()
        setPost9Constraint()
        setPost10Constraint()
    }
    
    
    
    func setImage(){
        postImageView1?.image = UIImage(named: "post1")
        postImageView2?.image = UIImage(named: "post2")
        postImageView3?.image = UIImage(named: "post3")
        postImageView4?.image = UIImage(named: "post4")
        postImageView5?.image = UIImage(named: "post5")
        postImageView6?.image = UIImage(named: "post6")
        postImageView7?.image = UIImage(named: "post7")
        postImageView8?.image = UIImage(named: "post8")
        postImageView9?.image = UIImage(named: "post9")
        postImageView10?.image = UIImage(named: "post10")
    }
    
    
    func setLabel(){
        postButton1?.setTitle("1", for: .normal)
        postButton2?.setTitle("2", for: .normal)
        postButton3?.setTitle("3", for: .normal)
        postButton4?.setTitle("4", for: .normal)
        postButton5?.setTitle("5", for: .normal)
        postButton6?.setTitle("6", for: .normal)
        postButton7?.setTitle("7", for: .normal)
        postButton8?.setTitle("8", for: .normal)
        postButton9?.setTitle("9", for: .normal)
        postButton10?.setTitle("10", for: .normal)
        
        postButton1?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton2?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton3?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton4?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton5?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton6?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton7?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton8?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton9?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        postButton10?.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        
        postButton1?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton2?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton3?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton4?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton5?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton6?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton7?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton8?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton9?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        postButton10?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    func addSubViews(){
        postContainerView1?.addSubview(postImageView1!)
        postContainerView1?.addSubview(postButton1!)
        postContainerView2?.addSubview(postImageView2!)
        postContainerView2?.addSubview(postButton2!)
        postContainerView3?.addSubview(postImageView3!)
        postContainerView3?.addSubview(postButton3!)
        postContainerView4?.addSubview(postImageView4!)
        postContainerView4?.addSubview(postButton4!)
        postContainerView5?.addSubview(postImageView5!)
        postContainerView5?.addSubview(postButton5!)
        postContainerView6?.addSubview(postImageView6!)
        postContainerView6?.addSubview(postButton6!)
        postContainerView7?.addSubview(postImageView7!)
        postContainerView7?.addSubview(postButton7!)
        postContainerView8?.addSubview(postImageView8!)
        postContainerView8?.addSubview(postButton8!)
        postContainerView9?.addSubview(postImageView9!)
        postContainerView9?.addSubview(postButton9!)
        postContainerView10?.addSubview(postImageView10!)
        postContainerView10?.addSubview(postButton10!)
        
        
        self.addSubview(postContainerView1!)
        self.addSubview(postContainerView2!)
        self.addSubview(postContainerView3!)
        self.addSubview(postContainerView4!)
        self.addSubview(postContainerView5!)
        self.addSubview(postContainerView6!)
        self.addSubview(postContainerView7!)
        self.addSubview(postContainerView8!)
        self.addSubview(postContainerView9!)
        self.addSubview(postContainerView10!)
    }
    
    func setPost1Constraint(){
        postContainerView1?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalToSuperview().offset(96)
            make.top.equalToSuperview().offset(103)
        }
        
        postImageView1?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton1?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func setPost2Constraint(){
        postContainerView2?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView1?.snp.left)!).offset(90)
            make.top.equalTo((self.postContainerView1?.snp.top)!).offset(37)
        }
        
        postImageView2?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton2?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview().offset(9)
            make.top.equalToSuperview().offset(4)
        }
    }
    
    func setPost3Constraint(){
        postContainerView3?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalToSuperview().offset(71)
            make.top.equalTo((self.postContainerView1?.snp.bottom)!).offset(1)
        }
        
        postImageView3?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton3?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    func setPost4Constraint(){
        postContainerView4?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView1?.snp.left)!).offset(36)
            make.top.equalTo((self.postContainerView1?.snp.top)!).offset(91)
        }
        
        postImageView4?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton4?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setPost5Constraint(){
        postContainerView5?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView4?.snp.left)!).offset(87)
            make.top.equalTo((self.postContainerView4?.snp.top)!).offset(53)
        }
        
        postImageView5?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton5?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-18)
            make.top.equalToSuperview()
        }
    }
    
    
    func setPost6Constraint(){
        postContainerView6?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalToSuperview().offset(63)
            make.top.equalTo((self.postContainerView3?.snp.top)!).offset(97)
        }
        
        postImageView6?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton6?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
    }
    
    
    func setPost7Constraint(){
        postContainerView7?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView4?.snp.left)!).offset(39)
            make.top.equalTo((self.postContainerView4?.snp.top)!).offset(98)
        }
        
        postImageView7?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton7?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview().offset(2)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    
    func setPost8Constraint(){
        postContainerView8?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalToSuperview().offset(85)
            make.top.equalTo((self.postContainerView6?.snp.top)!).offset(80)
        }
        
        postImageView8?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton8?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(61)
        }
    }
    
    func setPost9Constraint(){
        postContainerView9?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView7?.snp.left)!).offset(11)
            make.top.equalTo((self.postContainerView7?.snp.top)!).offset(81)
        }
        
        postImageView9?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton9?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setPost10Constraint(){
        postContainerView10?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalTo((self.postContainerView8?.snp.left)!).offset(74)
            make.top.equalTo((self.postContainerView8?.snp.top)!).offset(60)
        }
        
        postImageView10?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        postButton10?.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(67)
        }
    }
}
