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
    func setModuleDatas(_ moduleDatas: TTMyDiarySet)
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTMyDiaryPresenter {
    weak var view : TTMyDiaryViewProtocol?
    fileprivate var moduleDatas  : TTMyDiarySet?
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

extension TTMyDiaryPresenter: TTMyDiaryPresenterProtocol,TTCurrentTimeGettable {
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
    
    
    
    func configureCell(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        var month = ""
        var day   = ""
        var start = ""
        var destination = ""
        
        if let monthStr = moduleDatas?.myDiaryDatas?[indexPath.section].month {
            month = convertMonthString(month: Int(monthStr)!)
        }
        
        if let data = moduleDatas?.myDiaryDatas?[indexPath.section].myDateDatas?[indexPath.row] {
            day = data.day ?? ""
            if let firstData = data.firstDiary {
                start = firstData.location ?? ""
            }else{
                if let lastData = data.lastDiary {
                    start       = lastData.location ?? ""
                    destination = lastData.location ?? ""
                }
            }
            
            if let lastData = data.lastDiary {
                destination = lastData.location ?? ""
            }
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TTMyDiaryCell") as? TTMyDiaryCell
        cell?.monthLabel.text       = month
        cell?.dayLabel.text         = day
        cell?.startLocation.text    = start
        cell?.destinationLabel.text = destination
        cell?.selectionStyle        = .none
        
        if indexPath.row == 0 {
            cell?.monthLabel.isHidden = false
            cell?.lineView.isHidden   = false
        }else{
            cell?.monthLabel.isHidden = true
            cell?.lineView.isHidden   = true
        }
        
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
    func setModuleDatas(_ moduleDatas: TTMyDiarySet) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    
}
