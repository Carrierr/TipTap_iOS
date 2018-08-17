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
}

final class TTMyDiaryInteractor: TTMyDiaryInteractorInputProtocol{
    private lazy var service = TTMyDiaryService()
    weak var presenter : TTMyDiaryInteractorOutputProtocol?
    
    
    func requestMyDiaryList() {
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
