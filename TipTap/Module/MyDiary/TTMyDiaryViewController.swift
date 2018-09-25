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
    
    @IBOutlet weak var tableView: UITableView!
    var presenter:TTMyDiaryPresenterProtocol?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func setupUI() {
//        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.contentInset   = UIEdgeInsetsMake(7, 0, 7, 0)
        self.tableView.separatorInset = UIEdgeInsetsMake(7, 0, 7, 0)
        registerCell()
    }
    
    override func setupBinding() {
        
    }
    
    func registerCell(){
        self.tableView.register(UINib.init(nibName:"TTMyDiaryCell",bundle:nil), forCellReuseIdentifier: "TTMyDiaryCell")
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
