//
//  TTTodayDiaryViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTTodayDiaryViewController: TTBaseViewController,TTCanShowAlert, TTCanSetupNavigation {
    var titleLabel : UILabel? = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 44.0))
    var rightBarButtonItem : UIBarButtonItem?  = UIBarButtonItem()
    
    @IBOutlet weak var postView: UIView!
    private var mainView       : TTPostMainView?
    private lazy var service = TTTodayDiaryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTodayDiaryNavigation(diaryCount: 3)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        requestTodayDiaryData()
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    //MARK: Draw UI
    override func setupUI() {
        mainView = TTPostMainView(frame: self.view.frame)
        mainView?.pressedPost = { (diaryDatas) in
            self.show(TTDetailDiaryWireFrame.createModule(diaryDatas: diaryDatas), sender: nil)
        }
        
        self.postView.addSubview(mainView!)
    }
    
    
    private func setupTodayDiaryNavigation(diaryCount count: Int){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else {
                return
        }
        titleLabel.text = "Today\n#\(count)"
        rightBarButtonItem.image = UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(goSetting)
    }
    
    
    
    //MARK: Request today diary data
    func requestTodayDiaryData(){
        guard let _ = mainView else { return }
        service.fetchTodayDiary { (result) in
            switch result {
            case .success(let result):
                self.mainView?.dataSet = TTDiaryDataSet(diaryDataList: result.diaryDataList!, stampNameList: result.stampNameList!)
                break
            case .errorMessage(let errorMsg):
                self.showAlert(title: "", message: errorMsg)
                break
                
            default : break
            }
        }
    }
    
    
    @IBAction func pressedWriteButton(_ sender: Any) {
        guard  let count =  self.mainView?.dataSet?.diaryDataList?.count else { return }
        if count >= 10 {
            showAlert(title: "", message: "하루에 작성할 일기는 10개까지입니다.")
        }else{
            self.present(UIStoryboard(name: "EditDiary", bundle: nil) .instantiateViewController(withIdentifier:"TTEditDiaryViewController"), animated: true, completion: nil)
        }
    }
    
    
    @objc private func goSetting(){
        
    }
}
