//
//  TTSettingViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 09/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit

enum TTSettingType{
    case switchButton(String)
    case normalButton(String)
}

class TTSettingViewController: TTBaseViewController {
    let settingData:[TTSettingType] = {
        return [TTSettingType.switchButton("일기 공유하기"),
                TTSettingType.switchButton("푸시 알림"),
                TTSettingType.normalButton("이용약관"),
                TTSettingType.normalButton("로그아웃")]
    }()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupBinding() {
        tableView.register(UINib(nibName: "TTSettingCell", bundle: nil), forCellReuseIdentifier: "TTSettingCell")
    }
    
    override func setupUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.topItem?.title = "";
        
        self.title = "설정"
    }
    
    
}

extension TTSettingViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
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

