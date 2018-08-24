//
//  TTSharedCollectionViewDiaryCell.swift
//  TipTap
//
//  Created by GAIN LEE on 2018. 8. 24..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTSharedCollectionViewDiaryCell: UICollectionViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        let tempView = TTSharedDiaryView(frame: self.view.frame)
        self.view.addSubview(tempView)
    }
}
