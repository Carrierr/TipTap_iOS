//
//  TTMyDiaryNormalCell.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTMyDiaryNormalCell: UITableViewCell {

    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startLocation: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        dayLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
