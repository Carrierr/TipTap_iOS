//
//  TTSharedViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

import Darwin
import ScratchCard
import SnapKit
import SwiftyJSON


class TTSharedViewController: TTBaseViewController, TTCanShowAlert, TTCanSetupNavigation {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var scratchImageNamed : String = ""
    private var scratchImageView : UIImageView?
    private var isFirstShow : Bool = true
    private let service = TTSharedService()
    private var scratchOriginalView : UIView?
    
    fileprivate var moduleDatas  : TTDiaryDataSet? {
        didSet{
            collectionView.reloadData()
            attachScratchView()
        }
    }
    
    var scratchView : ScratchUIView!
    
    var titleLabel : UILabel? = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 44.0))
    var rightBarButtonItem: UIBarButtonItem? = UIBarButtonItem()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestSharedDiary()
        
        
        let randomNumber = arc4random_uniform(3) + 1
        self.scratchImageNamed = "scratch0\(randomNumber).png"
        self.scratchImageView = UIImageView(image: UIImage(named: scratchImageNamed))
        self.scratchImageView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(scratchImageView!)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    internal override func setupUI() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.setupNavigation()
    }
    
    
    private func makeScratchOriginView(){
        self.scratchOriginalView = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height))
        let imageView = UIImageView(frame: CGRect(x:0, y:20, width:self.view.frame.width, height:self.view.frame.height))
        self.scratchOriginalView?.addSubview(imageView)
        imageView.image = self.view.asImage()
    }
    
    
    
    func setupSharedDiaryNavigation(diaryCount count: Int){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else {
                return
        }
        titleLabel.text = "\(count)\nTIPTAP"
        rightBarButtonItem.image = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(showMoreOption)
    }
    
    
    

    private func attachScratchView(){
        //Coupon : 지우고 나서의 원본 이미지
        //MaskImage : 지울 이미지
        guard isFirstShow else { return }
        if let scratchImageView = scratchImageView {
            scratchImageView.removeFromSuperview()
        }
        
        self.view.layoutIfNeeded()
        makeScratchOriginView()
        scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),
                                     Coupon: (self.scratchOriginalView?.asImage())!,
                                     MaskImage: scratchImageNamed,
                                     ScratchWidth: CGFloat(40))
        scratchView.delegate = self
        self.view.addSubview(scratchView)
        self.isFirstShow = false
    }
    
    
    
    private func requestSharedDiary(){
        service.fetchSharedDiaryList { (result) in
            switch result{
            case .success(let result):
                print(" result : \(result)")
                self.moduleDatas = result
                break
                
            case .error(_):
                
                break
                
            case .errorMessage(let errorMsg):
                self.showAlert(title: "오류", message: errorMsg)
                break
            }
        }
    }
    
    
    
    @objc func showMoreOption(){
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
                    if json["code"].intValue == 4000{
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



extension TTSharedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = moduleDatas?.diaryDataList?.count {
            return count + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharedDiaryCell", for: indexPath) as! TTSharedCollectionViewDiaryCell
            cell.dataSet = moduleDatas
            cell.locationLabel.text = "from. 서울시 마포구 망원동"
    
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharedDiaryListCell", for: indexPath) as! TTSharedCollectionViewListCell
            guard let diaryItem = moduleDatas?.diaryDataList?[indexPath.row-1] else { return cell }
            
            cell.timeLabel.text = "11:30"
            cell.diaryNumberLabel.text = "\(indexPath.row)"
            cell.locationLabel.text = diaryItem.location
            cell.bodyLabel.text = diaryItem.content
            
            return cell
        }
    }
}

extension TTSharedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0 ) {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: 1, height: 1)
        }
    }
}


