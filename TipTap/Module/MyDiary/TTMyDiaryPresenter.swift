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
    func sumbitDelteItems()
    
    //UITableView
    func didSelectTableViewRowAt(indexPath: IndexPath)
    func numberOfRows(in section:Int)->Int
    func numberOfSection()->Int
    func configureCell(_ tableView:UITableView,
                       forRowAt indexPath : IndexPath,
                       isDeletable : Bool,
                       isInitDelete : Bool)->UITableViewCell
}


protocol TTMyDiaryInteractorOutputProtocol: class {
    //Interactor->Presenter
    func setModuleDatas(_ moduleDatas: TTMyDiarySet)
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTMyDiaryPresenter {
    weak var view : TTMyDiaryViewProtocol?
    fileprivate var moduleDatas  : TTMyDiarySet?
    fileprivate let wireframe    : TTMyDiaryWireFrameProtocol
    fileprivate let interactor   : TTMyDiaryInteractorInputProtocol
    fileprivate lazy var deleteItems : [String] = [String]()
    
    init(
        view        : TTMyDiaryViewProtocol,
        wireframe   : TTMyDiaryWireFrameProtocol,
        interactor  : TTMyDiaryInteractorInputProtocol){
        self.view       = view
        self.wireframe  = wireframe
        self.interactor = interactor
    }
}


extension TTMyDiaryPresenter: TTMyDiaryPresenterProtocol, TTCurrentTimeGettable {
    func numberOfRows(in section: Int) -> Int {
        if let count = moduleDatas?.myDiaryDatas?[section].myDateDatas?.count {
            return count
        }
        return 0
    }
    
    
    
    func numberOfSection() -> Int {
        if let count = moduleDatas?.myDiaryDatas?.count {
            return count
        }
        return 0
    }
    
    
    
    func didSelectTableViewRowAt(indexPath: IndexPath) {
        print("select \(indexPath.row)")
        guard let diaryData = moduleDatas?.myDiaryDatas?[indexPath.section],
            let day = diaryData.myDateDatas?[indexPath.row].day else { return }
        
        let dateStr = "\(diaryData.year ?? "")-\(diaryData.month ?? "")-\(day)"
        wireframe.navigate(to: .show(dateString: dateStr))
    }
    
    
    
    func configureCell(_ tableView:UITableView,
                       forRowAt indexPath : IndexPath,
                       isDeletable : Bool,
                       isInitDelete : Bool)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TTMyDiaryCell") as? TTMyDiaryCell
        if let data = moduleDatas?.myDiaryDatas?[indexPath.section].myDateDatas?[indexPath.row] {
            cell?.diaryData = data
        }

        if let monthStr = moduleDatas?.myDiaryDatas?[indexPath.section].month {
            cell?.monthLabel.text  = convertMonthString(month: Int(monthStr)!)
        }
        
        if indexPath.row == 0 {
            cell?.monthLabel.isHidden = false
            cell?.lineView.isHidden   = false
        }else{
            cell?.monthLabel.isHidden = true
            cell?.lineView.isHidden   = true
        }
        
        if isDeletable {
            cell?.checkBox.isHidden = false
        }else{
            cell?.checkBox.isHidden = true
        }
        
        if isInitDelete{
            cell?.checkBox.isSelected = false
        }
        
        cell?.delegate = self
        
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
    
    func sumbitDelteItems(){
        guard deleteItems.count > 0 else { return }
        interactor.requestDeleteDiary(deleteDiaryItems: deleteItems)
    }
}


extension TTMyDiaryPresenter : TTMyDiaryInteractorOutputProtocol{
    func setModuleDatas(_ moduleDatas: TTMyDiarySet) {
        self.moduleDatas = moduleDatas
        guard let count = self.moduleDatas?.myDiaryDatas?.count else {
            view?.stopNetworking(hasData : false)
            return
        }
        view?.stopNetworking(hasData: count > 0)
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        wireframe.navigate(to: .alert(title: "", message: message))
    }
}


extension TTMyDiaryPresenter : TTMyDiaryCellDelegate{
    func checkDeleteBox(cell : TTMyDiaryCell, isSelected:Bool, diaryData : TTMyDiaryDayData){
        guard isSelected else {
            if deleteItems.contains(diaryData.lastDiary?.createdAt ?? "") {
                deleteItems = deleteItems.filter{
                    $0 != diaryData.lastDiary?.createdAt
                }
            }
            
            return
        }
        deleteItems.append(diaryData.lastDiary?.createdAt ?? "")
    }
}
