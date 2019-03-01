//
//  TTSettingViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 09/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit

enum TTSettingType{
    case switchButton(title : String, isOn : Bool, pressed : ((Bool)-> ()) )
    case normalButton(String)
}


class TTSettingViewController: TTBaseViewController, TTCanShowAlert {
    
    
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate let settingData:[TTSettingType] = {
        return [
            TTSettingType.switchButton(title: "일기 공유하기", isOn: TTDeviceInfo.SettingInfo.isSharedMyDiary, pressed: { isOn in
                TTDeviceInfo.SettingInfo.isSharedMyDiary = isOn
                if isOn{
                    TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/account/share/on", method:.post, completion: { (result) in
                        print("result : \(result)")
                    })
                }else{
                    TTAPIManager.sharedManager.requestAPI("\(TTAPIManager.API_URL)/account/share/off", method:.post, completion: { (result) in
                        print("result : \(result)")
                    })
                }
            }),
            TTSettingType.switchButton(title: "푸시 알림", isOn: TTDeviceInfo.SettingInfo.isOnPushNotification, pressed: { isOn in
                TTDeviceInfo.SettingInfo.isOnPushNotification = isOn
                if isOn{
                    NotificationCenter.default.post(name: NSNotification.Name.userNoti.isOnUserNoti, object: nil)
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name.userNoti.isOffUserNoti, object: nil)
                }
                }),
                TTSettingType.normalButton("이용약관"),
                TTSettingType.normalButton("로그아웃")]
    }()
    
    var haveTodayDiaryDatas : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name.ablePaging.changedDisablePaging, object: nil)
    }
    
    deinit {
        NotificationCenter.default.post(name: Notification.Name.ablePaging.changedAblePaging, object: nil)
    }
    
    override func setupBinding() {
        tableView.register(UINib(nibName: "TTSettingCell", bundle: nil), forCellReuseIdentifier: "TTSettingCell")
        NotificationCenter.default.addObserver(self, selector: #selector(notiOn), name: NSNotification.Name.userNoti.isOnUserNoti, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nofiOff), name: NSNotification.Name.userNoti.isOffUserNoti, object: nil)
    }
    
    
    override func setupUI() {
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        navigationController?.navigationBar.tintColor = UIColor.black;
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.topItem?.title = "";
        
        self.title = "설정"
    }
    
    
    @objc func notiOn(){
        if haveTodayDiaryDatas {
            appDelegate?.registerLocalNoti()
        }
    }
    
    @objc func nofiOff(){
        appDelegate?.unregisterLocalNoti()
    }
    
}

extension TTSettingViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                let vc = TTTermsOfServiceViewController(nibName: "TTTermsOfServiceViewController", bundle: nil)
                self.show(vc, sender: nil)
            }
        }else if indexPath.section == 1{
            showAlert(title: "알림", message: "로그아웃하시겠습니까?", completion: {
                appDelegate?.logout()
            }) {
                
            }
            
        }
    }
}


extension TTSettingViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TTSettingCell = tableView.dequeueReusableCell(withIdentifier: "TTSettingCell", for: indexPath) as! TTSettingCell
        
        if indexPath.section == 0 {
            cell.data = settingData[indexPath.row]
        }else if indexPath.section == 1{
            cell.data = settingData[3]
        }
        
        return cell
    }
}

