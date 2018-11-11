//
//  TTDiaryOutlineContainer.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import SnapKit

protocol TTDiaryOutlineContainer : TTCanHasDiaryData, TTCurrentTimeGettable where Self : UIView {
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
        
        titleLabel.text = "Today\n#\(dataSet?.diaryDataList?.count ?? 0)"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(-20)
            } else {
                make.top.equalToSuperview().offset(-20)
            }
            make.centerX.equalToSuperview()
        }
        
        
        
        yearLabel.text = "\(currentYear())`"
        yearLabel.textColor = UIColor(hexString: "6D6D6D")
        yearLabel.font = UIFont.systemFont(ofSize: 13)
        yearLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(113)
            make.left.equalToSuperview().offset(21)
        }
        
        monthLabel.text = "\(convertMonthString(month: Int(currentMonth()) ?? 0 ))"
        monthLabel.textColor = UIColor(hexString: "6D6D6D")
        monthLabel.font = UIFont.systemFont(ofSize: 13)
        monthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(yearLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
        }
        
        dateLabel.text = "\(currentDay())"
        dateLabel.textColor = UIColor(hexString: "6D6D6D")
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom)
            make.left.equalToSuperview().offset(21)
        }
        
        horLineView.backgroundColor = UIColor(hexString: "8B8B8B")
        horLineView.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(21)
            make.bottom.equalTo(brandLabel.snp.top).offset(-30)
        }
        
        brandLabel.text = "TIPTAP"
        brandLabel.textColor = UIColor(hexString: "6D6D6D")
        brandLabel.font = UIFont.systemFont(ofSize: 13)
        brandLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
        brandLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(firstDescLabel.snp.top).offset(-35)
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
        
        
        guard let count = dataSet?.diaryDataList?.count,
            count > 0 else{
            firstDescLabel.isHidden = false
            return
        }
        
        firstDescLabel.isHidden = true
        
    }
}


