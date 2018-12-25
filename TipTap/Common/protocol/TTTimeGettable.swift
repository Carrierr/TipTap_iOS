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
protocol TTTimeGettable {
    func currentTime()->String
    func convertMonthString(month:Int)->String
}

extension TTTimeGettable {
    
    func currentTime()->String {
        let now = Date()
        let formatter = getDateFormat(format: "yyyy MMM dd - HH:mm")
        return formatter.string(from: now)
        //        formatter.dateFormat = "yyyy MMM dd E HH:mm" //2018 Aug 24 Fri 00:26
    }
    
    
    func currentDate(format:String)->String{
        let now = Date()
        let formatter = getDateFormat(format: format)
        return formatter.string(from: now)
    }
    
    
    func getMidnight()->Date{
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = NSTimeZone.local
        let dateAtMidnight = calendar.startOfDay(for: Date())
        
        //For End Date
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let dateAtEnd = calendar.date(byAdding: components, to: dateAtMidnight)
        //자정 되기 15분 전
        return (dateAtEnd?.addingTimeInterval(-60*60))!
    }
    

    
    func dateConvert(dateString:String, format : String)->String{
        
        let dateFormatter = getDateFormat(format: "yyyy-MM-dd")
        let myDate = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: myDate!)
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
    
  
    
    private func getDateFormat(format:String)->DateFormatter{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter
    }
}
