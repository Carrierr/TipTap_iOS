//
//  TTDetailDiaryInteractor.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

/*
 presenter -> interactor
 */
protocol TTDetailDiaryInteractorInputProtocol: class {
    //request list
    func requestDetailDiaryList()
    func requetDeleteDiary()
}

final class TTDetailDiaryInteractor: TTDetailDiaryInteractorInputProtocol{
    
    private lazy var service = TTDetailDiaryService()
    weak var presenter : TTDetailDiaryInteractorOutputProtocol?
    var diaryDatas     : [TTDiaryData]?
    var dateString     : String?
    
    
    func requestDetailDiaryList() {
        if let diaryDatas = diaryDatas {
            self.presenter?.setModuleDatas(diaryDatas)
        }
        
        guard let dateString = dateString else { return }
        service.fetchDetailDiaryList(dateString: dateString) { (result) in
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
    
    
    
    func requetDeleteDiary(){
        if let dateString = dateString {
            //MY DIARY 리스트에서 삭제
            service.fetchDeleteDiary(deleteDate: dateString) { (result) in
                switch result{
                case .success(let result):
                    self.presenter?.completeDeleteDiary()
                    break
                case .error(let error):
                    self.presenter?.didReceivedError(error)
                    break
                    
                case .errorMessage(let errorMsg):
                    self.presenter?.showMessage(message: errorMsg)
                    break
                }
            }
        }else {
            //오늘의 일기에서 삭제
            service.fetchDeleteDiary(deleteID: "\(diaryDatas?.first?.id ?? 0)") { (result) in
                switch result{
                case .success(let result):
                    self.presenter?.completeDeleteDiary()
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
}
