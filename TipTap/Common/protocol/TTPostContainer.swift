//
//  TTPostContainer.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SnapKit

protocol TTPostContainer : TTCanHasDiaryData where Self : UIView {
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
    
    var postLabel1           : UILabel? { get set }
    var postLabel2           : UILabel? { get set }
    var postLabel3           : UILabel? { get set }
    var postLabel4           : UILabel? { get set }
    var postLabel5           : UILabel? { get set }
    var postLabel6           : UILabel? { get set }
    var postLabel7           : UILabel? { get set }
    var postLabel8           : UILabel? { get set }
    var postLabel9           : UILabel? { get set }
    var postLabel10          : UILabel? { get set }
    
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
            let _ = postLabel1,
            let _ = postLabel2,
            let _ = postLabel3,
            let _ = postLabel4,
            let _ = postLabel5,
            let _ = postLabel6,
            let _ = postLabel7,
            let _ = postLabel8,
            let _ = postLabel9,
            let _ = postLabel10 else {
                return
        }
        
        //addSubView
        addSubViews()
        
        postContainerView1?.isHidden  = true
        postContainerView2?.isHidden  = true
        postContainerView3?.isHidden  = true
        postContainerView4?.isHidden  = true
        postContainerView5?.isHidden  = true
        postContainerView6?.isHidden  = true
        postContainerView7?.isHidden  = true
        postContainerView8?.isHidden  = true
        postContainerView9?.isHidden  = true
        postContainerView10?.isHidden = true
        
        setLabel()
        showPostContainer()
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
    
    
    
    private func setButtonImage(postButton button: UIButton, imageNamed: String){
        button.setImage(UIImage(named: imageNamed), for: .normal)
//        postButton1?.setImage(UIImage(named: "post1"), for: .normal)
//        postButton2?.setImage(UIImage(named: "post2"), for: .normal)
//        postButton3?.setImage(UIImage(named: "post3"), for: .normal)
//        postButton4?.setImage(UIImage(named: "post4"), for: .normal)
//        postButton5?.setImage(UIImage(named: "post5"), for: .normal)
//        postButton6?.setImage(UIImage(named: "post6"), for: .normal)
//        postButton7?.setImage(UIImage(named: "post7"), for: .normal)
//        postButton8?.setImage(UIImage(named: "post8"), for: .normal)
//        postButton9?.setImage(UIImage(named: "post9"), for: .normal)
//        postButton10?.setImage(UIImage(named: "post10"), for: .normal)
    }
    
    
    private func setLabel(){
        postLabel1?.text  = "01"
        postLabel2?.text  = "02"
        postLabel3?.text  = "03"
        postLabel4?.text  = "04"
        postLabel5?.text  = "05"
        postLabel6?.text  = "06"
        postLabel7?.text  = "07"
        postLabel8?.text  = "08"
        postLabel9?.text  = "09"
        postLabel10?.text = "10"
        
        postLabel1?.textColor  = UIColor(hexString: "808080")
        postLabel2?.textColor  = UIColor(hexString: "808080")
        postLabel3?.textColor  = UIColor(hexString: "808080")
        postLabel4?.textColor  = UIColor(hexString: "808080")
        postLabel5?.textColor  = UIColor(hexString: "808080")
        postLabel6?.textColor  = UIColor(hexString: "808080")
        postLabel7?.textColor  = UIColor(hexString: "808080")
        postLabel8?.textColor  = UIColor(hexString: "808080")
        postLabel9?.textColor  = UIColor(hexString: "808080")
        postLabel10?.textColor = UIColor(hexString: "808080")
        
        postLabel1?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel2?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel3?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel4?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel5?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel6?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel7?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel8?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel9?.font  = UIFont.boldSystemFont(ofSize: 10)
        postLabel10?.font = UIFont.boldSystemFont(ofSize: 10)
        
        postLabel1?.sizeToFit()
        postLabel2?.sizeToFit()
        postLabel3?.sizeToFit()
        postLabel4?.sizeToFit()
        postLabel5?.sizeToFit()
        postLabel6?.sizeToFit()
        postLabel7?.sizeToFit()
        postLabel8?.sizeToFit()
        postLabel9?.sizeToFit()
        postLabel10?.sizeToFit()
    }
    
    
    
    private func addSubViews(){
        postContainerView1?.addSubview(postLabel1!)
        postContainerView1?.addSubview(postButton1!)
        postContainerView2?.addSubview(postLabel2!)
        postContainerView2?.addSubview(postButton2!)
        postContainerView3?.addSubview(postLabel3!)
        postContainerView3?.addSubview(postButton3!)
        postContainerView4?.addSubview(postLabel4!)
        postContainerView4?.addSubview(postButton4!)
        postContainerView5?.addSubview(postLabel5!)
        postContainerView5?.addSubview(postButton5!)
        postContainerView6?.addSubview(postLabel6!)
        postContainerView6?.addSubview(postButton6!)
        postContainerView7?.addSubview(postLabel7!)
        postContainerView7?.addSubview(postButton7!)
        postContainerView8?.addSubview(postLabel8!)
        postContainerView8?.addSubview(postButton8!)
        postContainerView9?.addSubview(postLabel9!)
        postContainerView9?.addSubview(postButton9!)
        postContainerView10?.addSubview(postLabel10!)
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
    
    
    private func showPostContainer(){
        guard let stampNameList = dataSet?.stampNameList else { return }
        for (index,stampData) in stampNameList.enumerated() {
            switch index {
            case 0:
                postContainerView1?.isHidden = false
                setButtonImage(postButton: postButton1!, imageNamed: stampData)
                break
            case 1:
                postContainerView2?.isHidden = false
                setButtonImage(postButton: postButton2!, imageNamed: stampData)
                break
            case 2:
                postContainerView3?.isHidden = false
                setButtonImage(postButton: postButton3!, imageNamed: stampData)
                break
            case 3:
                postContainerView4?.isHidden = false
                setButtonImage(postButton: postButton4!, imageNamed: stampData)
                break
            case 4:
                postContainerView5?.isHidden = false
                setButtonImage(postButton: postButton5!, imageNamed: stampData)
                break
            case 5:
                postContainerView6?.isHidden = false
                setButtonImage(postButton: postButton6!, imageNamed: stampData)
                break
            case 6:
                postContainerView7?.isHidden = false
                setButtonImage(postButton: postButton7!, imageNamed: stampData)
                break
            case 7:
                postContainerView8?.isHidden = false
                setButtonImage(postButton: postButton8!, imageNamed: stampData)
                break
            case 8:
                postContainerView9?.isHidden = false
                setButtonImage(postButton: postButton9!, imageNamed: stampData)
                break
            case 9:
                postContainerView10?.isHidden = false
                setButtonImage(postButton: postButton10!, imageNamed: stampData)
                break
            default:
                break
            }
        }
    }
    
    
    private func setPost1Constraint(){
        postContainerView1?.snp.makeConstraints { (make) in
            make.width.equalTo(87)
            make.height.equalTo(98)
            make.right.equalTo(self.snp.centerX).offset(10)
            make.bottom.equalTo(self.snp.centerY).offset(-130)
        }
        
        postLabel1?.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        postButton1?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo((postLabel1?.snp.right)!).offset(0.5)
        }
        
        postLabel1?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
    }
    
    
    
    private func setPost2Constraint(){
        postContainerView2?.snp.makeConstraints { (make) in
            make.width.equalTo(74)
            make.height.equalTo(111)
            make.left.equalTo((self.postContainerView1?.snp.right)!).offset(4)
            make.top.equalTo((self.postContainerView1?.snp.top)!).offset(57)
        }
        
        postLabel2?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        postButton2?.snp.makeConstraints { (make) in
            make.top.equalTo((postLabel2?.snp.bottom)!)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    
    private func setPost3Constraint(){
        postContainerView3?.snp.makeConstraints { (make) in
            make.width.equalTo(98)
            make.height.equalTo(82)
            make.top.equalTo((self.postContainerView1?.snp.bottom)!).offset(1)
            make.right.equalTo((self.postContainerView2?.snp.left)!).offset(-16)
        }
        
        postLabel3?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        postButton3?.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(-15)
            
            make.width.equalTo(73)
            make.height.equalTo(98)
        }
        
        postButton3?.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2));
    }
    
    
    
    private func setPost4Constraint(){
        postContainerView4?.snp.makeConstraints { (make) in
            make.width.equalTo(91)
            make.height.equalTo(98)
            make.top.equalTo((self.postContainerView2?.snp.bottom)!).offset(7)
            make.left.equalTo((self.postContainerView2?.snp.left)!).offset(-28)
        }
        
        postLabel4?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        postButton4?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalTo((postLabel4?.snp.left)!).offset(3)
        }
    }
    
    
    
    private func setPost5Constraint(){
        postContainerView5?.snp.makeConstraints { (make) in
            make.width.equalTo(93)
            make.height.equalTo(98)
            make.right.equalTo((self.postContainerView4?.snp.left)!).offset(1)
            make.top.equalTo((self.postContainerView4?.snp.top)!).offset(44)
        }
        
        postLabel5?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        postButton5?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo((postLabel5?.snp.right)!)
        }
        
        postLabel5?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
    }
    
    
    
    
    private func setPost6Constraint(){
        postContainerView6?.snp.makeConstraints { (make) in
            make.width.equalTo(88)
            make.height.equalTo(98)
            make.left.equalTo((self.postButton4?.snp.right)!).offset(-3)
            make.top.equalTo((self.postContainerView4?.snp.top)!).offset(43)
        }
        
        postLabel6?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        postButton6?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalTo((postLabel6?.snp.left)!)
        }
    }
    
    
    
    private func setPost7Constraint(){
        postContainerView7?.snp.makeConstraints { (make) in
            make.width.equalTo(74)
            make.height.equalTo(111)
            make.left.equalTo((self.postContainerView4?.snp.left)!)
            make.top.equalTo((self.postContainerView4?.snp.bottom)!).offset(8)
        }
        
        postLabel7?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        postButton7?.snp.makeConstraints { (make) in
            make.top.equalTo((postLabel7?.snp.bottom)!)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    
    
    private func setPost8Constraint(){
        postContainerView8?.snp.makeConstraints { (make) in
            make.width.equalTo(98)
            make.height.equalTo(82)
            make.top.equalTo((self.postContainerView5?.snp.bottom)!).offset(17)
            make.right.equalTo((self.postContainerView7?.snp.left)!).offset(-16)
        }
        
        postLabel8?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        postButton8?.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(-15)
            
            make.width.equalTo(73)
            make.height.equalTo(98)
        }
        
        
        postButton8?.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2));
    }
    
    
    
    private func setPost9Constraint(){
        postContainerView9?.snp.makeConstraints { (make) in
            make.width.equalTo(74)
            make.height.equalTo(111)
            make.left.equalTo((self.postContainerView6?.snp.left)!)
            make.top.equalTo((self.postContainerView6?.snp.bottom)!).offset(4)
        }
        
        postLabel9?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        postButton9?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo((postLabel9?.snp.top)!)
        }
    }
    
    
    
    private func setPost10Constraint(){
        postContainerView10?.snp.makeConstraints { (make) in
            make.width.equalTo(86)
            make.height.equalTo(98)
            make.right.equalTo((self.postContainerView7?.snp.right)!)
            make.top.equalTo((self.postContainerView7?.snp.bottom)!).offset(3)
        }
        
        postLabel10?.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        postButton10?.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo((postLabel10?.snp.right)!)
        }
        
        postLabel10?.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2));
    }
}
