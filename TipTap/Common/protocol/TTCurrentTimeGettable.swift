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
    func convertMonthString(month:Int)->String
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
    
    func convertMonthString(month:Int)->String{
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
}
