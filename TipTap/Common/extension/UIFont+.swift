//
//  UIFont+.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    static func montserratLight(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "Montserrat-Light", size: size)!
    }
    
    static func montserratRegular(fontSize size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    static func montserratMedium(fontSize size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    
    static func montserratBold(fontSize size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }
    
    
    static func KoPubDotumProLight(fontSize size:CGFloat) -> UIFont{
        return UIFont(name: "KoPubDotumPL", size: size)!
    }
    
    static func KoPubDotumProMedium(fontSize size:CGFloat) -> UIFont{
        return UIFont(name: "KoPubDotumPM", size: size)!
    }
    
    static func KoPubDotumProBold(fontSize size:CGFloat) -> UIFont{
        return UIFont(name: "KoPubDotumPB", size: size)!
    }
}


