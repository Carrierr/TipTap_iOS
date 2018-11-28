//
//  TTDeviceInfo.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 9. 14..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

struct TTDeviceInfo {
    struct UserInfo{
        static var token : String{
            set(newVal){
                UserDefaults.standard.setValue(newVal, forKey: "tokenID")
            }
            
            get{
                
                if let token = UserDefaults.standard.object(forKey: "tokenID") as? String {
                    return token
                }
                
                
                TTAuthAPIManager.sharedManager.login(loginFlatform: loginPlatform ?? .kakao, account: userID ?? "", name: nickName ?? "", completion: { (result) in
                    switch result {
                    case .success( _):
                        
                        break
                    case .error( _):
                        
                        break
                    case .errorMessage(_):
                        
                        break
                    }
                })
                
                return ""
            }
        }
        
        static var nickName : String?{
            set{
                UserDefaults.standard.setValue(newValue, forKey: "nickname")
            }
            get{
                return UserDefaults.standard.object(forKey: "nickname") as? String
            }
        }
        
        
        static var userID : String? {
            set{
                UserDefaults.standard.setValue(newValue, forKey: "userID")
            }
            get{
                return UserDefaults.standard.object(forKey: "userID") as? String
            }
        }
        
        static var loginPlatform : TTAuthLoginPlatformType?{
            set{
                UserDefaults.standard.setValue(newValue, forKey: "loginPlatform")
            }
            get{
                return UserDefaults.standard.object(forKey: "loginPlatform") as? TTAuthLoginPlatformType
            }
        }
    }
    
    struct SettingInfo{
        static var isFirstLaunch : Bool{
            set(newVal){
                UserDefaults.standard.setValue(newVal, forKey: "isFirstLaunch")
            }
            
            get{
                if let isFirst = UserDefaults.standard.object(forKey: "isFirstLaunch") as? Bool {
                    return isFirst
                }
                return true
            }
        }
    }
    
    
    struct DeviceInfo {
        static var isIphoneX : Bool{
            get{
                if #available(iOS 11.0, *) {
                    let window = UIApplication.shared.keyWindow
                    let topPadding = window?.safeAreaInsets.top
                    if topPadding! > CGFloat(0) {
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }
        }
    }
}
