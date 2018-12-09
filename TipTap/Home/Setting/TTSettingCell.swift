//
//  TTSettingCell.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 09/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit

class TTSettingCell: UITableViewCell {
    var data : TTSettingType? {
        didSet{
            contentChanged()
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func contentChanged(){
        guard let data = data else { return }
        switch data {
        case .switchButton(let title):
            titleLabel.text = title
            switchButton.isHidden = false
            
        case .normalButton(let title) :
            titleLabel.text = title
            switchButton.isHidden = true
            
        }
    }
    
    
    @IBAction func pressedSwitch(_ sender: Any) {
        
    }
    
}
