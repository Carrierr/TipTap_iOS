//
//  TTDetailDiaryOutlineView.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

class TTDetailDiaryOutlineView: UIView, TTDiaryOutlineContainer {
    var dataSet: TTDiaryDataSet?
    
    var yearLabel: UILabel? = UILabel()
    
    var monthLabel: UILabel? = UILabel()
    
    var dateLabel: UILabel? = UILabel()
    
    var horLineView: UIView? = UIView()
    
    var brandLabel: UILabel? = UILabel()
    
    var firstDescLabel: UILabel?  = UILabel()
    
    var titleLabel: UILabel? = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentChangedOutline()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
