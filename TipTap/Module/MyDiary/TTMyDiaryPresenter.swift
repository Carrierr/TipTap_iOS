//
//  TTMyDiaryPresenter.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTMyDiaryPresenterProtocol: TTBasePresenterProtocol {
    //View->Presenter
    func reloadData()
    
    //UITableView
    func didSelectTableViewRowAt(indexPath: IndexPath)
    func numberOfRows(in section:Int)->Int
    func numberOfSection()->Int
    func configureCell(_ tableView:UITableView, forRowAt indexPath : IndexPath)->UITableViewCell
}


protocol TTMyDiaryInteractorOutputProtocol: class {
    //Interactor->Presenter
    func setModuleDatas(_ moduleDatas: [String])
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTMyDiaryPresenter {
    weak var view : TTMyDiaryViewProtocol?
    fileprivate var moduleDatas  : [String]?
    fileprivate let wireframe    : TTMyDiaryWireFrameProtocol
    fileprivate let interactor   : TTMyDiaryInteractorInputProtocol
    
    init(
        view        : TTMyDiaryViewProtocol,
        wireframe   : TTMyDiaryWireFrameProtocol,
        interactor  : TTMyDiaryInteractorInputProtocol){
        self.view       = view
        self.wireframe  = wireframe
        self.interactor = interactor
    }
}

extension TTMyDiaryPresenter: TTMyDiaryPresenterProtocol {
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


extension TTMyDiaryPresenter : TTMyDiaryInteractorOutputProtocol{
    func setModuleDatas(_ moduleDatas: [String]) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    
}
