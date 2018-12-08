//
//  TTCanSetupNavigation.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTCanSetupNavigation where Self:UIViewController {
    var titleLabel                 : UILabel? { get set }
    var rightBarButtonItem : UIBarButtonItem? { get set }
    func setupNavigation()
}



extension TTCanSetupNavigation{
    func setupNavigation(){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else { return }
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.montserratMedium(fontSize: 16)
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
             
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
