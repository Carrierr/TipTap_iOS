//
//  NotificationExtension.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

extension Notification.Name{
    struct ablePaging{
        static let changedAblePaging:Notification.Name = Notification.Name("isAblePaging")
        static let changedDisablePaging:Notification.Name = Notification.Name("disablePaging")
        static let changedDidScratch:Notification.Name = Notification.Name("didScratch")
    }

    struct refreshPage {
        static let sharedDiary:Notification.Name = Notification.Name("refreshSharedDiary")
    }
    
    
    struct userNoti {
        static let isOnUserNoti : Notification.Name = Notification.Name("isOnUserNoti")
        static let isOffUserNoti : Notification.Name = Notification.Name("isOffUserNoti")
    }
}

