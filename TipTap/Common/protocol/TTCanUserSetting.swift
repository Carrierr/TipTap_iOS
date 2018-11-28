//
//  TTCanGoLoginView.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 27/11/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTCanUserSetting {
    func goLogout()
}

extension TTCanUserSetting{
    func goLogout(){
        let loginVC = UIStoryboard(name: "TTLogin", bundle: nil).instantiateViewController(withIdentifier: "TTLoginViewController") as UIViewController
        appDelegate?.window?.rootViewController = UINavigationController(rootViewController: loginVC)
        UserDefaults.standard.removeObject(forKey: "tokenID")
    }
}
