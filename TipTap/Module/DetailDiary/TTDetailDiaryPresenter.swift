//
//  TTDetailDiaryPresenter.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTDetailDiaryPresenterProtocol: TTBasePresenterProtocol {
    //View->Presenter
    func reloadData()
    
    //UITableView
    func didSelectTableViewRowAt(indexPath: IndexPath)
    func numberOfRows(in section:Int)->Int
    func numberOfSection()->Int
    func configureCell(_ tableView:UITableView, forRowAt indexPath : IndexPath)->UITableViewCell
}


protocol TTDetailDiaryInteractorOutputProtocol: class {
    //Interactor->Presenter
    func setModuleDatas(_ moduleDatas: [String])
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTDetailDiaryPresenter {
    weak var view : TTDetailDiaryViewProtocol?
    fileprivate var moduleDatas  : [String]?
    fileprivate let wireframe    : TTDetailDiaryWireFrameProtocol
    fileprivate let interactor   : TTDetailDiaryInteractorInputProtocol
    
    init(
        view        : TTDetailDiaryViewProtocol,
        wireframe   : TTDetailDiaryWireFrameProtocol,
        interactor  : TTDetailDiaryInteractorInputProtocol){
        self.view       = view
        self.wireframe  = wireframe
        self.interactor = interactor
    }
}

extension TTDetailDiaryPresenter: TTDetailDiaryPresenterProtocol {
    func numberOfRows(in section: Int) -> Int {
        if let count = moduleDatas?.count {
            return count
        }
        return 0
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func didSelectTableViewRowAt(indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
    
    func configureCell(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryCell") as? MyDiaryCell
        if let title = moduleDatas?[indexPath.row] {
            cell?.titleLabel.text = title
        }
        cell?.monthLabel.text = "July"
        cell?.dayLabel.text   = "22"
        return cell!
    }
    
    func moreLoad() {
        
    }
    
    func onViewDidLoad(){
        reloadData()
    }
    
    func reloadData(){
        view?.startNetworking()
        interactor.requestMyDiaryList()
    }
    
    
    
}


extension TTDetailDiaryPresenter : TTDetailDiaryInteractorOutputProtocol{
    func setModuleDatas(_ moduleDatas: [String]) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    
}
