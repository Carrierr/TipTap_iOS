//
//  TTMyDiaryFirstCell.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 25..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

protocol TTMyDiaryCellDelegate {
    func checkDeleteBox(cell : TTMyDiaryCell, isSelected:Bool, diaryData : TTMyDiaryDayData)
}

class TTMyDiaryCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startLocation: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dotImageView: UIImageView!
    
    
    var diaryData : TTMyDiaryDayData?{
        didSet{
            setData()
        }
    }
    var delegate : TTMyDiaryCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 3 / 2));
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func setData(){
        guard  let diaryData = diaryData else { return }
        var day   = ""
        var start = ""
        var destination = ""
        
        day = diaryData.day ?? ""
        if let firstData = diaryData.firstDiary {
            start = firstData.location ?? ""
            startLocation.numberOfLines = 1
            dotImageView.isHidden     = false
            destinationLabel.isHidden = false
        }else{
            if let lastData = diaryData.lastDiary {
                start       = lastData.location ?? ""
                startLocation.numberOfLines = 0
                dotImageView.isHidden     = true
                destinationLabel.isHidden = true
            }
        }
        
        if let lastData = diaryData.lastDiary {
            destination = lastData.location ?? ""
        }
        
       titleLabel.text = "\(diaryData.count) TIPTAP"
        dayLabel.text         = day
        startLocation.text    = start
        destinationLabel.text = destination
        self.selectionStyle        = .none
    }
    
    
    @IBAction func pressedButton(_ sender: Any) {
        checkBox.isSelected = !checkBox.isSelected
        guard let delegate = delegate else { return }
        delegate.checkDeleteBox(cell: self, isSelected: checkBox.isSelected, diaryData: diaryData!)
    }
    
}
