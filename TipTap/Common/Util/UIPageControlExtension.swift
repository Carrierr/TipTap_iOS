//
//  UIPageContrlsExtension.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 3..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

extension UIPageControl {
    func customPageControl(dotFillColor:UIColor,
                           dotBorderColor:UIColor,
                           dotBorderWidth:CGFloat) {
        
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
}

