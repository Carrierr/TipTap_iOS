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
    @IBOutlet weak var emptyDescLabel: UILabel!
    @IBOutlet weak var scrollImageView: UIImageView!
    
    var dataSet : TTDiaryDataSet?{
        didSet{
            let tempView = TTSharedDiaryView(frame: self.view.bounds)
            if let dataSet = dataSet{
                if let _ = dataSet.diaryDataList{
                    tempView.dataSet = dataSet
                }
                
            }
            self.view.addSubview(tempView)
            
            tempView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-35)
            }
        }
    }
    
    override func awakeFromNib() {
        locationLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
    }
}

