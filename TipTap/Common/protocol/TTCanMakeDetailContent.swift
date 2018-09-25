//
//  TTCanMakeDetailContent.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
protocol TTCanMakeDetailContent {
    func makeDetailContent(diaryData  : TTDiaryData)->[TTDetailDiaryContent]?
    func makeDetailContent(diaryDatas : [TTDiaryData])->[TTDetailDiaryContent]?
}

extension TTCanMakeDetailContent{
    func makeDetailContent(diaryData  : TTDiaryData)->[TTDetailDiaryContent]?{
        var detailContents : [TTDetailDiaryContent]? = [TTDetailDiaryContent]()
        
        if let imageURL = diaryData.imageUrl{
            detailContents?.append(TTDetailDiaryContent(type: .image, URLString:imageURL))
        }
        
        if let content = diaryData.content{
            detailContents?.append(TTDetailDiaryContent(type: .text, note:content))
        }
        
        guard let contents = detailContents else { return nil }
        return contents
    }
    
    func makeDetailContent(diaryDatas : [TTDiaryData])->[TTDetailDiaryContent]?{
        var detailContents : [TTDetailDiaryContent]? = [TTDetailDiaryContent]()
        for diaryData in diaryDatas {
            if let imageURL = diaryData.imageUrl{
                detailContents?.append(TTDetailDiaryContent(type: .image, URLString:imageURL))
            }
            
            if let content = diaryData.content{
                detailContents?.append(TTDetailDiaryContent(type: .text, note:content))
            }
        }
        
        
        guard let contents = detailContents else { return nil }
        return contents
    }
}
