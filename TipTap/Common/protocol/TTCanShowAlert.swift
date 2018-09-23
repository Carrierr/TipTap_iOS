//
//  TTCanShowAlert.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 22..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTCanShowAlert {
    func showAlert(title : String?, message:String?, completion:(()->())?)
}

extension TTCanShowAlert{
    func showAlert(title : String?, message:String?, completion:(()->())? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "확인", style: .default, handler: { (result) in
            if (completion != nil) {
                completion!()
            }
        })
        
        alertController.addAction(confirmAlert)
        
        appDelegate?.searchFrontViewController().present(alertController, animated: true, completion: nil)
    }
}
