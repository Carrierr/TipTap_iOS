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
    @IBOutlet var locationLabel: UILabel!
    var dataSet : TTDiaryDataSet?{
        didSet{
            let tempView = TTSharedDiaryView(frame: self.view.bounds)
            tempView.dataSet = dataSet
            self.view.addSubview(tempView)
        }
    }
    
    override func awakeFromNib() {
        locationLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(-45)
        }
    }
}

