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
            if var dataSet = dataSet{
                /*
                 API 이슈로 공유받은 일기 스탬프는 클라에서 직접 그리기
                 */
                dataSet.stampNameList = [String]()
                for _ in dataSet.diaryDataList!{
                    let randomNumber = arc4random_uniform(13) + 1
                    dataSet.stampNameList?.append("stamp\(randomNumber)")
                }
                tempView.dataSet = dataSet
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
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(-45)
        }
    }
}

