//
//  TTSearchViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 02/12/2018.
//  Copyright © 2018 Tiptap. All rights reserved.
//

import UIKit
import MapKit

import SnapKit
import RxSwift
import RxCocoa

protocol TTSearchViewControllerDelegate {
    func searchPlace(_: TTSearchViewController, keyword: String, completion: @escaping (([MKMapItem]) -> ()))
}


class TTSearchViewController: TTBaseViewController  {
    var delegate : TTSearchViewControllerDelegate?
    
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    fileprivate var locationItems : [MKMapItem]? {
        didSet{
            self.searchTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func setupUI(){
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        searchTableView.separatorStyle = .none
    }
    
    
    
    override func setupBinding() {
        searchTableView.register(TTSearchLocationCell.self, forCellReuseIdentifier: "TTSearchLocationCell")
//        let bag = DisposeBag()
//        searchTextField.rx.controlEvent(.editingChanged).bind {
//            print("editing state changed")
//            }.disposed(by:bag)
//
//
//        searchTextField.rx.text.bind{_ in
//
//            }.disposed(by:bag)

    }
}



extension TTSearchViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let delegate = delegate {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                delegate.searchPlace(self, keyword: self.searchTextField.text ?? "",completion: { items in
                    self.locationItems = items
                })
            }
        }
        return true
    }
}



extension TTSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}



extension TTSearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.locationItems?.count else{
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = self.locationItems else {
            return UITableViewCell()
        }
        
        let cell : TTSearchLocationCell = tableView.dequeueReusableCell(withIdentifier: "TTSearchLocationCell", for: indexPath) as! TTSearchLocationCell
        cell.mapItem = items[indexPath.row]
        return cell
    }
}




fileprivate class TTSearchLocationCell : UITableViewCell{
    var mapItem : MKMapItem?{
        didSet{
            contentChanged()
        }
    }
    
    private lazy var titleLocation  : UILabel = UILabel()
    private lazy var detailLocation : UILabel = UILabel()
    
    override func awakeFromNib() {
        
    }
    
    private func setupUI(){
        self.addSubview(titleLocation)
        self.addSubview(detailLocation)
        
        titleLocation.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(11.7)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
        }
        
        detailLocation.snp.makeConstraints { (make) in
            make.top.equalTo(titleLocation.snp.bottom).offset(6)
            make.left.equalTo(titleLocation)
            make.right.equalTo(titleLocation)
        }
        
        titleLocation.font = UIFont.KoPubDotumProMedium(fontSize: 14)
        detailLocation.font = UIFont.KoPubDotumProMedium(fontSize: 12)
        detailLocation.textColor = UIColor.lightGray
    }
    
    private func contentChanged(){
        setupUI()
        guard let mapItem = mapItem else { return }
        titleLocation.text  = mapItem.name ?? ""
        detailLocation.text = mapItem.placemark.title ?? ""
    }
}
