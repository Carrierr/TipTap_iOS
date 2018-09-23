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
    private var mainView       : TTPostMainView?
    private lazy var service = TTTodayDiaryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestTodayDiaryData()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    //MARK: Draw UI
    override func setupUI() {
        mainView = TTPostMainView(frame: self.view.frame)
        mainView?.pressedPost = { (postIndex) in
            self.show(TTDetailDiaryWireFrame.createModule(), sender: nil)
        }
        
        self.postView.addSubview(mainView!)
    }
    
    
    //MARK: Request today diary data
    func requestTodayDiaryData(){
        guard let _ = mainView else { return }
        service.fetchTodayDiary { (result) in
            switch result {
            case .success(let result):
                self.mainView?.dataSet = TTDiaryDataSet(diaryDataList: result.diaryDataList!, stampNameList: result.stampNameList!)
                break
            default : break
            }
        }
    }
}
