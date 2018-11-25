//
//  NotificationExtension.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

extension Notification.Name{
    struct IsAblePaging{
        static let changedAblePaging:Notification.Name = Notification.Name("isAblePaging")
    }
    
    struct disablePaging{
        static let changedAblePaging:Notification.Name = Notification.Name("disablePaging")
    }
}

