//
//  TTMyDiaryViewController.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

protocol TTMyDiaryViewProtocol:class{
    func startNetworking()
    func stopNetworking()
}

class TTMyDiaryViewController: TTBaseViewController {
    
    
    @IBOutlet private weak var calendarButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var intervalSafeView: UIView!
    @IBOutlet private weak var intervalDateLabel: UILabel!
    @IBOutlet private weak var intervalDateView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    var presenter:TTMyDiaryPresenterProtocol?
    var startDate : String?
    var endDate  : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    
    override func setupUI() {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.contentInset   = UIEdgeInsetsMake(7, 0, 7, 0)
        self.tableView.separatorInset = UIEdgeInsetsMake(7, 0, 7, 0)
        
        guard let startDate = startDate,
            let endDate = endDate else {
                intervalDateView.isHidden = true
                intervalSafeView.isHidden = true
                cancelButton.isHidden = true
                calendarButton.isHidden = false
                return
        }
        
        intervalDateView.isHidden   = false
        intervalSafeView.isHidden   = false
        cancelButton.isHidden        = false
        calendarButton.isHidden     =  true
        
        intervalDateLabel.text = "\(startDate)  -  \(endDate)"
    }
    
    
    override func setupBinding() {
        self.registerCell()
    }
    
    
    private func registerCell(){
        self.tableView.register(UINib.init(nibName:"TTMyDiaryCell",bundle:nil), forCellReuseIdentifier: "TTMyDiaryCell")
    }
    
    
    @IBAction func pressedCalendar(_ sender: Any) {
        let selectVC = SelectCalendarViewController.init(nibName: "SelectCalendarViewController", bundle: nil)
        self.present(selectVC, animated: true, completion: nil)
    }
    
    @IBAction func pressedCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TTMyDiaryViewController: TTMyDiaryViewProtocol {
    func startNetworking() {
        self.tableView.reloadData()
    }
    
    func stopNetworking() {
        self.tableView.reloadData()
    }
}

extension TTMyDiaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectTableViewRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }
}



extension TTMyDiaryViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.numberOfSection())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfRows(in: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (presenter?.configureCell(tableView, forRowAt: indexPath))!
    }
}
