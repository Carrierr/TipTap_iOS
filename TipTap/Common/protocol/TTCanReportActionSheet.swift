//
//  TTCanReportActionSheet.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 26..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol TTCanReportActionSheet:TTCanShowAlert where Self : TTBaseViewController{
    func showReportActionSheet()
    var moduleDatas  : TTDiaryDataSet? { get set }
}

extension TTCanReportActionSheet {
    func showReportActionSheet(){
        guard let data = self.moduleDatas?.diaryDataList?[0] else { return }
        weak var weakSelf = self
        
        let declare = UIAlertAction(title: "신고하기", style: .destructive, handler: { (action) -> Void in
            let reportAction : ((String)->Void)? = { reason in
                let parameter = ["content_id":"\(data.id ?? 0)",
                    "type":reason,
                    "target_user_id":"\(data.user_id ?? 0)"
                ]
                
                TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/blame/report", method: .post,parameters: parameter) { (result) in
                    let json = JSON(result)
                    if json["code"].intValue == 1000{
                        weakSelf?.showAlert(title: "신고 접수 완료", message: "신고가 접수되었습니다.", completion: {
                            NotificationCenter.default.post(name: NSNotification.Name.refreshPage.sharedDiary, object: nil)
                        })
                    }else{
                        weakSelf?.showAlert(title: "", message: String.errorString)
                    }
                }
            }
            
            let pornReason = UIAlertAction(title: "음란성 글", style: .destructive, handler: { (action) in
                reportAction!("porn")
            })
            
            let  addReason = UIAlertAction(title: "굉고성 글", style: .destructive, handler: { (action) in
                reportAction!("ad")
            })
            
            let otherReason = UIAlertAction(title: "기타", style: .destructive, handler: { (action) in
                reportAction!("other")
            })
            
            weakSelf?.showActionSheet(sheetActions: pornReason,addReason,otherReason)
        })
        
        let block = UIAlertAction(title: "차단하기", style: .destructive, handler: { (action) -> Void in
            
            weakSelf?.showAlert(title: "차단하시겠습니까?", message: "차단 사용자가 보낸 일기는 더 이상 볼 수 없습니다.", completion: {
                let param = ["user_id":data.user_id]
                TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/diary/block", method: .post,parameters: param) { (result) in
                    let json = JSON(result)
                    if json["code"].intValue == 1000{
                        NotificationCenter.default.post(name: NSNotification.Name.refreshPage.sharedDiary, object: nil)
                    }else{
                        weakSelf?.showAlert(title: "", message: String.errorString)
                    }
                }
            }, cancelAction: {
            })
        })
        weakSelf?.showActionSheet(sheetActions: declare,block)
    
    }
}


