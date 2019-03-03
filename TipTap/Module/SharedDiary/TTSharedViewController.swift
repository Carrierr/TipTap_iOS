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


class TTSharedViewController: TTBaseViewController, TTCanShowAlert, TTCanSetupNavigation,TTCanReportActionSheet {
    var scratchView : ScratchUIView!
    var titleLabel : UILabel? = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 44.0))
    var rightBarButtonItem: UIBarButtonItem? = UIBarButtonItem()
    var moduleDatas  : TTDiaryDataSet? {
        didSet{

            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates({
            }) { (finished) in
                if TTDeviceInfo.DeviceInfo.isIphoneX {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.attachScratchView()
                    }
                }else{
                    self.attachScratchView()
                }
            }
        }
    }
    
    private let service = TTSharedService()
    private var scratchImageNamed : String = ""
    private var scratchImageView : UIImageView?
    private var isFirstShow : Bool = true
    private var scratchOriginalView : UIView?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserver()
        let randomNumber = arc4random_uniform(2) + 1
        self.scratchImageNamed = "scratch0\(randomNumber).png"
        self.scratchImageView = UIImageView(image: UIImage(named: scratchImageNamed))
        self.scratchImageView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(scratchImageView!)
    }
    
    
    
    internal override func setupUI() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.setupNavigation()
    }
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSharedDiary), name: NSNotification.Name.refreshPage.sharedDiary, object: nil)
    }
    
    
    
    private func makeScratchOriginView(){
        self.scratchOriginalView = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height))
        let imageView = UIImageView(frame: CGRect(x:0, y:20, width:self.view.frame.width, height:self.view.frame.height))
        self.scratchOriginalView?.addSubview(imageView)
        imageView.image = self.view.asImage()
    }
    
    
    
    func setupSharedDiaryNavigation(diaryCount count: Int,buttonHidden isHidden:Bool){
        guard let titleLabel = titleLabel,
            var rightBarButtonItem = rightBarButtonItem else {
                return
        }
        titleLabel.text = "POSTBOX"
        if isHidden{
            rightBarButtonItem = UIBarButtonItem()
            return
        }
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
        
        
            self.makeScratchOriginView()
            self.scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),
                                         Coupon: (self.scratchOriginalView?.asImage())!,
                                         MaskImage: self.scratchImageNamed,
                                         ScratchWidth: CGFloat(40))
            self.scratchView.delegate = self
            self.view.addSubview(self.scratchView)
            self.isFirstShow = false

    }
    
    
    
    
    func requestSharedDiary(){
        service.fetchSharedDiaryList { (result) in
            
            switch result{
            case .success(var result):
                print(" result : \(result)")
                
                /*
                 API 이슈로 공유받은 일기 스탬프는 클라에서 직접 그리기
                 */
                result.stampNameList = [String]()
                if let list = result.diaryDataList {
                    for _ in list{
                        let randomNumber = arc4random_uniform(13) + 1
                        result.stampNameList?.append("stamp\(randomNumber)")
                    }
                }
                
                
                self.moduleDatas = result
                break
                
            case .error(_):
                break
                
            case .errorMessage(let errorMsg):
                self.showAlert(title: "오류", message: errorMsg, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name.refreshPage.sharedDiary, object: nil)
                })
                break
            }
        }
    }
    
    
    @objc private func refreshSharedDiary(){
        isFirstShow = true
    }
    
    @objc private func showMoreOption(){
        showReportActionSheet()
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
            if let count = moduleDatas?.diaryDataList?.count, count > 0 {
                cell.locationLabel.text = "from. \(moduleDatas?.diaryDataList?[0].city ?? "")"
                cell.descStackView.isHidden      = false
                cell.emptyDescLabel.isHidden = true
            }else{
                cell.descStackView.isHidden = true
                cell.emptyDescLabel.isHidden = false
            }
            
    
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharedDiaryListCell", for: indexPath) as! TTSharedCollectionViewListCell
            guard let diaryItem = moduleDatas?.diaryDataList?[indexPath.row-1] else { return cell }
            cell.data = diaryItem
            cell.widthConst.constant = collectionView.frame.width
            return cell
        }
    }
}

extension TTSharedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0 ) {
            return CGSize(width: collectionView.frame.width, height: 337)
        } else {
            return CGSize(width: collectionView.frame.width, height: 1)
        }
    }
}


