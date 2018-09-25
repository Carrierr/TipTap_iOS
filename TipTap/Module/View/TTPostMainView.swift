//
//  TTPostTempView.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTPostMainView: UIView, TTDiaryOutlineContainer, TTPostContainer {
    var dataSet: TTDiaryDataSet?{
        didSet{
            contentChangedOutline()
            contentChangedPost()
            bindingButtonAction()
        }
    }
    
    
    var postLabel1: UILabel? = UILabel()
    var postLabel2: UILabel? = UILabel()
    var postLabel3: UILabel? = UILabel()
    var postLabel4: UILabel? = UILabel()
    var postLabel5: UILabel? = UILabel()
    var postLabel6: UILabel? = UILabel()
    var postLabel7: UILabel? = UILabel()
    var postLabel8: UILabel? = UILabel()
    var postLabel9: UILabel? = UILabel()
    var postLabel10: UILabel? = UILabel()
    
    var postContainerView1: UIView? = UIView()
    var postContainerView2: UIView? = UIView()
    var postContainerView3: UIView? = UIView()
    var postContainerView4: UIView? = UIView()
    var postContainerView5: UIView? = UIView()
    var postContainerView6: UIView? = UIView()
    var postContainerView7: UIView? = UIView()
    var postContainerView8: UIView? = UIView()
    var postContainerView9: UIView? = UIView()
    var postContainerView10: UIView? = UIView()
    
    var postButton1: UIButton? = UIButton()
    var postButton2: UIButton? = UIButton()
    var postButton3: UIButton? = UIButton()
    var postButton4: UIButton? = UIButton()
    var postButton5: UIButton? = UIButton()
    var postButton6: UIButton? = UIButton()
    var postButton7: UIButton? = UIButton()
    var postButton8: UIButton? = UIButton()
    var postButton9: UIButton? = UIButton()
    var postButton10: UIButton? = UIButton()
    
    var yearLabel: UILabel? = UILabel()
    var monthLabel: UILabel? = UILabel()
    var dateLabel: UILabel? = UILabel()
    var horLineView: UIView? = UIView()
    var brandLabel: UILabel? = UILabel()
    var firstDescLabel: UILabel? = UILabel()
    var titleLabel: UILabel? = UILabel()
    
    var pressedPost : ((_ diaryDatas : [TTDiaryData])->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bindingButtonAction(){
        postButton1?.tag = 0
        postButton1?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton2?.tag = 1
        postButton2?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton3?.tag = 2
        postButton3?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton4?.tag = 3
        postButton4?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton5?.tag = 4
        postButton5?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton6?.tag = 5
        postButton6?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton7?.tag = 6
        postButton7?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton8?.tag = 7
        postButton8?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton9?.tag = 8
        postButton9?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)
        postButton10?.tag = 9
        postButton10?.addTarget(self, action: #selector(pressedPostButton(sender:)), for: .touchUpInside)

    }
    
    
    @objc private func pressedPostButton(sender : UIButton){
        guard let pressedPost = pressedPost else { return }
        guard let todayDiaryDatas = dataSet?.diaryDataList else { return }
//        let detailContents = makeDetailContent(diaryData: todayDiaryDatas[sender.tag])
        let detailContent = todayDiaryDatas[sender.tag]
        var datas = [TTDiaryData]()
        datas.append(detailContent)
        
        print("tag : \(datas)")
        pressedPost(datas)
    }
    
}
