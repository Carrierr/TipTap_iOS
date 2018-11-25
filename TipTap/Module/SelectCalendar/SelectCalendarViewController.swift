//
//  SelectCalendarViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 11. 3..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class SelectCalendarViewController: UIViewController, TTCanShowAlert {

    
    @IBOutlet private weak var endDateButton: UIButton!
    @IBOutlet private weak var startDateButton: UIButton!
    @IBOutlet private weak var endDateWidth: NSLayoutConstraint!
    @IBOutlet private weak var startDateWidth: NSLayoutConstraint!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    private var startDate : String? {
        didSet{
            startDateButton.setTitle(startDate, for: .normal)
        }
    }
    
    private var endDate  : String? {
        didSet{
            endDateButton.setTitle(endDate, for: .normal)
        }
    }
    
    private var pickerDate : String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let date = dateformatter.string(from: datePicker.date)
        return date
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNoti()
    }
    
    
    private func setupUI(){
        startDateWidth.constant = self.view.frame.width / 2 + 30
        endDateWidth.constant   = self.view.frame.width / 2 + 30
        
        startDate = pickerDate
        endDate = pickerDate
        
        datePicker.locale = Locale(identifier: "ko")
        datePicker.setValue(UIColor(hexString: "7AC8BC"), forKey: "textColor")
    }
    
    private func registerNoti(){
        self.datePicker.addTarget(self, action: #selector(changedDataPikcer), for: .valueChanged)
    }
    
    
    @objc private func changedDataPikcer(){
        if startDateButton.isSelected {
            startDate = pickerDate
        }
        
        if endDateButton.isSelected {
            endDate = pickerDate
        }
    }
    
    
    
    @IBAction private func pressedStartDate(_ sender: Any) {
        if startDateButton.isSelected {
            startDate = pickerDate
        }else{
            endDate  = pickerDate
        }
        datePicker.setDate(Date(), animated: true)
        
        startDateButton.isSelected = true
        startDateButton.titleLabel?.font = UIFont.montserratMedium(fontSize:16)
        endDateButton.isSelected  = false
        endDateButton.titleLabel?.font = UIFont.montserratLight(fontSize: 16)
        self.view.bringSubview(toFront: startDateButton)
    }
    
    
    
    @IBAction private func pressedEndDate(_ sender: Any) {
        if endDateButton.isSelected {
            endDate  = pickerDate
        }else{
            startDate = pickerDate
        }
        datePicker.setDate(Date(), animated: true)
        
        endDateButton.isSelected  = true
        endDateButton.titleLabel?.font = UIFont.montserratMedium(fontSize: 16)
        startDateButton.isSelected = false
        startDateButton.titleLabel?.font = UIFont.montserratLight(fontSize:16)
        self.view.bringSubview(toFront: endDateButton)
    }
    
    
    
    @IBAction func pressedConfirmButton(_ sender: Any) {
        guard let startDate = startDate,
                   let endDate = endDate else {
                showAlert(title: "", message: String.errorString)
                return
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let start = dateformatter.date(from: startDate)
        let end = dateformatter.date(from: endDate)
        
        if start?.compare(end!) == ComparisonResult.orderedDescending {
            showAlert(title: "", message: "끝 날짜를 시작 날짜 이후로 설정해주세요.")
            return;
        }
        
        self.dismiss(animated: true) {
            let myDiary = TTMyDiaryWireFrame.createModule(startDate : startDate, endDate : endDate)
            let mdVC = UINavigationController(rootViewController: myDiary)

            appDelegate?.searchFrontViewController().present( mdVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

