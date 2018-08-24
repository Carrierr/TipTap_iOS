//
//  TTDetailDiaryViewController.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

protocol TTDetailDiaryViewProtocol:class{
    func startNetworking()
    func stopNetworking()
}

class TTDetailDiaryViewController: TTBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter:TTDetailDiaryPresenterProtocol?
    @IBOutlet weak var outlineView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = TTDetailDiaryOutlineView(frame: self.view.frame)
        outlineView.addSubview(mainView)
//        presenter?.onViewDidLoad()
    }

    override func setupUI() {
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        registerCell()
    }
    
    override func setupBinding() {
        
    }
    
    func registerCell(){
        self.tableView.register(UINib.init(nibName:"MyDiaryCell",bundle:nil), forCellReuseIdentifier: "MyDiaryCell")
    }
}

extension TTDetailDiaryViewController: TTDetailDiaryViewProtocol {
    func startNetworking() {
        
    }
    
    func stopNetworking() {
        self.tableView.reloadData()
    }
    
}

extension TTDetailDiaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectTableViewRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



extension TTDetailDiaryViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfRows(in: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (presenter?.configureCell(tableView, forRowAt: indexPath))!
    }
}
