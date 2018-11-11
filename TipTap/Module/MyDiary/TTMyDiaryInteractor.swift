//
//  TTMyDiaryInteractor.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

/*
 presenter -> interactor
 */
protocol TTMyDiaryInteractorInputProtocol: class {
    //request list
    func requestMyDiaryList()
    //DELETE ITEM
    func requestDeleteDiary(deleteDiaryItems : [String])
}

final class TTMyDiaryInteractor: TTMyDiaryInteractorInputProtocol{
    private lazy var service = TTMyDiaryService()
    weak var presenter : TTMyDiaryInteractorOutputProtocol?
    
    var startDate : String?
    var endDate  : String?
    
    func requestMyDiaryList() {
        if let startDate = startDate,
            let endDate = endDate {
            service.fetchMyDiaryList(startDate: startDate, endDate: endDate) { (result) in
                switch result{
                case .success(let result):
                    self.presenter?.setModuleDatas(result)
                    break
                case .error(let error):
                    self.presenter?.didReceivedError(error)
                    break
                case .errorMessage(let errorMsg):
                    self.presenter?.showMessage(message: errorMsg)
                    break
                }
            }
        }else{
            service.fetchMyDiaryList { (result) in
                switch result{
                case .success(let result):
                    self.presenter?.setModuleDatas(result)
                    break
                case .error(let error):
                    self.presenter?.didReceivedError(error)
                    break
                case .errorMessage(let errorMsg):
                    self.presenter?.showMessage(message: errorMsg)
                    break
                }
            }
        }
    }
    
    
    func requestDeleteDiary(deleteDiaryItems : [String]){
        service.fetchDeleteMyDiaryList(diaryItems: deleteDiaryItems) { (result) in
            switch result {
            case .success(_):
                self.requestMyDiaryList()
                self.presenter?.showMessage(message: "삭제가 완료되었습니다.")
                break
            case .error(let error):
                self.presenter?.didReceivedError(error)
                break
            case .errorMessage(let errorMsg):
                self.presenter?.showMessage(message: errorMsg)
                break
            }
        }
    }
}
