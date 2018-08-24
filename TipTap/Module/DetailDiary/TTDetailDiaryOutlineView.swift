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
    var yearLabel: UILabel?
    
    var monthLabel: UILabel?
    
    var dateLabel: UILabel?
    
    var horLineView: UIView?
    
    var brandLabel: UILabel?
    
    var firstDescLabel: UILabel?
    
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentChangedOutline()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
