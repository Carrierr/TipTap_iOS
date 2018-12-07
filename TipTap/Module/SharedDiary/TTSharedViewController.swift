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
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.collectionView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.attachScratchView()
            }
        }
    }
    
    private let service = TTSharedService()
    private var scratchImageNamed : String = ""
    private var scratchImageView : UIImageView?
    private var isFirstShow : Bool = true
    private var scratchOriginalView : UIView?
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        titleLabel.text = "\(count)\nTIPTAP"
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
        
//        self.view.layoutIfNeeded()
        makeScratchOriginView()
        scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),
                                     Coupon: (self.scratchOriginalView?.asImage())!,
                                     MaskImage: scratchImageNamed,
                                     ScratchWidth: CGFloat(40))
        scratchView.delegate = self
        self.view.addSubview(scratchView)
        self.isFirstShow = false
    }
    
    
    
    
    func requestSharedDiary(){
        service.fetchSharedDiaryList { (result) in
            
            switch result{
            case .success(let result):
                print(" result : \(result)")
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
            cell.dataSet = moduleDatas
            if let count = moduleDatas?.diaryDataList?.count, count > 0 {
                cell.locationLabel.text = "from. \(moduleDatas?.diaryDataList?[0].location ?? "")"
                cell.emptyDescLabel.isHidden = true
                cell.scrollImageView.isHidden = false
            }else{
                cell.locationLabel.text = "from."
                cell.emptyDescLabel.isHidden = false
                cell.scrollImageView.isHidden = true
            }
            
    
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharedDiaryListCell", for: indexPath) as! TTSharedCollectionViewListCell
            guard let diaryItem = moduleDatas?.diaryDataList?[indexPath.row-1] else { return cell }
            
            cell.timeLabel.text = diaryItem.createTime
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


