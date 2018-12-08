//
//  TTSharedDiaryCollectionViewCell.swift
//  TipTap
//
//  Created by GAIN LEE on 2018. 8. 22..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTSharedCollectionViewListCell: UICollectionViewCell {
    
    
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet weak var widthConst: NSLayoutConstraint!
    @IBOutlet var diaryNumberLabel: UILabel!
    
    var data : TTDiaryData?{
        didSet{
                setData()
        }
    }
    
    private func setData(){
        guard let data = data else { return }
        timeLabel.text = data.createTime
        locationLabel.text = data.location
        bodyLabel.text = data.content
        bodyLabel.setLineSpacing(lineSpacing: 6)
    }
    
}
