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
}

final class TTDetailDiaryInteractor: TTDetailDiaryInteractorInputProtocol{
    
    private lazy var service = TTDetailDiaryService()
    weak var presenter : TTDetailDiaryInteractorOutputProtocol?
    
    
    func requestDetailDiaryList() {
        service.fetchDetailDiaryList { (result) in
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