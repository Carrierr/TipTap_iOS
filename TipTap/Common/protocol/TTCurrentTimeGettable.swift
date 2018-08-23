//
//  TTCurrentTimeGettable.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

/*
 http://nsdateformatter.com/
 reference data format 
 */
protocol TTCurrentTimeGettable {
    func currentTime()->String
}

extension TTCurrentTimeGettable {
    func currentTime()->String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        //        formatter.dateFormat = "yyyy MMM dd E HH:mm" //2018 Aug 24 Fri 00:26
        formatter.dateFormat = "yyyy MMM dd - HH:mm"
        return formatter.string(from: now)
    }
}
