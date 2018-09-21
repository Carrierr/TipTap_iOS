//
//  TTTodayDiaryViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTTodayDiaryViewController: TTBaseViewController {
    @IBOutlet weak var postView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTodayDiaryData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    //MARK: Draw UI
    override func setupUI() {
        let mainView = TTPostMainView(frame: self.view.frame)
        mainView.pressedPost = { (postIndex) in
            self.show(TTDetailDiaryWireFrame.createModule(), sender: nil)
        }
        
        self.postView.addSubview(mainView)
    }
    
    
    //MARK: Request today diary data
    func requestTodayDiaryData(){
        
    }
}
