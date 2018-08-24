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


class TTSharedViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var scratchView : ScratchUIView!
    var diarys = [TestDiary]()
    
    let location = ["키오스크 카페", "SEOUL COFFEE", "ZERO SPACE"]
    let body = ["오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!", "오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!","오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!오늘 날씨는 하루종일 맑음. 어제도 오늘도 너무 더워서 아무생각이 들지 않는다. 숙소에서 나와 가장 먼저 들른 곳!"]
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<3 {
            let diary = TestDiary(number: "#\(i+1)", location: location[i], body: body[i])
            diarys.append(diary)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachScratchView()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }

    func attachScratchView(){
        //Coupon : 지우고 나서의 원본 이미지
        //MaskImage : 지울 이미지
        
        let randomNumber = arc4random_uniform(3) + 1
        
        scratchView  = ScratchUIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height),
                                     Coupon: self.view.asImage(),
                                     MaskImage: "scratch0\(randomNumber).png",
                                     ScratchWidth: CGFloat(40))
        scratchView.delegate = self
        self.view.addSubview(scratchView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TTSharedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diarys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharedDiaryCell", for: indexPath) as! TTSharedCollectionViewCell
        
        let diary = diarys[indexPath.row]
        cell.timeLabel.text = "11:30"
        cell.diaryNumberLabel.text = diary.number
        cell.locationLabel.text = diary.location
        cell.bodyLabel.text = diary.body
        
        return cell
    }
}

