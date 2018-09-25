//
//  TTDetailDiaryContent.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation


struct TTDetailDiaryContent {
    enum ContentType {
        case image
        case text
    }
    
    var type: TTDetailDiaryContent.ContentType
    var URLString: URL?
    var note: String?
    
    init(type : ContentType, URLString : URL) {
        self.type = type
        self.URLString = URLString
    }
    
    init(type : ContentType, note : String) {
        self.type = type
        self.note = note
    }
}
