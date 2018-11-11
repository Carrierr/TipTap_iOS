//
//  TTDetailDiaryWireFrame.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

enum TTDetailDiaryRouterType{
    case show(item: [String])
    case alert(title: String, message: String)
    case alertCompletion(title: String, message: String, completion:(()->()))
}

protocol TTDetailDiaryWireFrameProtocol: class {
    func navigate(to route:TTDetailDiaryRouterType)
}

final class TTDetailDiaryWireFrame: TTBaseWireFrame, TTDetailDiaryWireFrameProtocol, TTCanShowAlert{
    func navigate(to route: TTDetailDiaryRouterType) {
        switch route {
        case .alert(let title, let message):
            showAlert(title: title, message: message)
            break
        case .show(let item):
            break
            
        case .alertCompletion(let title, let message, let completion):
            showAlert(title: title, message: message,completion: completion)
            break
        }
        
    }
    
    static func createModule(dateString : String? = nil,
                             diaryDatas:[TTDiaryData]? = nil)
        ->TTDetailDiaryViewController{
        let view       = UIStoryboard(name: "DetailDiary", bundle: nil) .
                            instantiateViewController(withIdentifier: "TTDetailDiaryViewController") as! TTDetailDiaryViewController
        let wireframe  = TTDetailDiaryWireFrame()
        let interactor = TTDetailDiaryInteractor()
        let presenter  = TTDetailDiaryPresenter(view: view, wireframe: wireframe, interactor: interactor)
        
        view.presenter        = presenter
        wireframe.view        = view
            
        interactor.presenter  = presenter
        interactor.diaryDatas = diaryDatas
        interactor.dateString = dateString
        
        return view
    }
    
}
