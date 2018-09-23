//
//  TTSharedDiaryView.swift
//  TipTap
//
//  Created by GAIN LEE on 2018. 8. 24..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTSharedDiaryView : UIView, TTPostContainer{
    var dataSet: TTDiaryDataSet?{
        didSet{
            contentChangedPost()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentChangedPost()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
