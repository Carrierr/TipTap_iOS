//
//  TTSharedCollectionViewDiaryCell.swift
//  TipTap
//
//  Created by GAIN LEE on 2018. 8. 24..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import SnapKit

class TTSharedCollectionViewDiaryCell: UICollectionViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var verLineView: UIView!
    
    override func awakeFromNib() {
        let tempView = TTSharedDiaryView(frame: self.view.frame)
        self.view.addSubview(tempView)
        
        locationLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(93)
            make.left.equalToSuperview().offset(-41)
        }
    }
}

