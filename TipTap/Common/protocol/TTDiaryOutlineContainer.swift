//
//  TTDiaryOutlineContainer.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SnapKit

protocol TTDiaryOutlineContainer where Self : UIView {
    var yearLabel      : UILabel? { get set }
    var monthLabel     : UILabel? { get set }
    var dateLabel      : UILabel? { get set }
    var horLineView    : UIView?  { get set }
    var brandLabel     : UILabel? { get set }
    var firstDescLabel : UILabel? { get set }
    var titleLabel     : UILabel? { get set }
    
    func contentChangedOutline()
}

extension TTDiaryOutlineContainer{
    func contentChangedOutline(){
        guard
            let yearLabel = yearLabel,
            let monthLabel = monthLabel,
            let dateLabel = dateLabel,
            let horLineView = horLineView,
            let brandLabel = brandLabel,
            let firstDescLabel = firstDescLabel,
            let titleLabel = titleLabel else {
                return
        }
        
        self.addSubview(titleLabel)
        self.addSubview(firstDescLabel)
        self.addSubview(brandLabel)
        self.addSubview(horLineView)
        self.addSubview(dateLabel)
        self.addSubview(monthLabel)
        self.addSubview(yearLabel)
        
        titleLabel.text = "Today\n#10"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(37)
            make.centerX.equalToSuperview()
        }
        
        
        
        yearLabel.text = "18`"
        yearLabel.font = UIFont.systemFont(ofSize: 14)
        yearLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(113)
            make.left.equalToSuperview().offset(21)
        }
        
        monthLabel.text = "Aug"
        monthLabel.font = UIFont.systemFont(ofSize: 14)
        monthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(yearLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
        }
        
        dateLabel.text = "02"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
        }
        
        horLineView.backgroundColor = UIColor(hexString: "8B8B8B", alpha: 0.5)
        horLineView.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
            make.bottom.equalTo(brandLabel.snp.top).offset(-20)
        }
        
        brandLabel.text = "TIPTAP"
        brandLabel.font = UIFont.systemFont(ofSize: 14)
        brandLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
        brandLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(firstDescLabel.snp.top).offset(-33.5)
        }

        firstDescLabel.text = "당신의\n첫번째 TIPTAP을\n작성해주세요."
        firstDescLabel.numberOfLines = 0
        firstDescLabel.font = UIFont.systemFont(ofSize: 28)
        firstDescLabel.textColor = UIColor(hexString: "373737", alpha: 0.65)
        firstDescLabel.snp.makeConstraints { (make) in
            make.top.equalTo(brandLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-106)
        }
        
    }
}


