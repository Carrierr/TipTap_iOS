//
//  TTMyDiaryWireFrame.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

enum TTMyDiaryRouterType{
    case show(dateString: String)
    case alert(title: String, message: String)
}

protocol TTMyDiaryWireFrameProtocol: class {
    func navigate(to route:TTMyDiaryRouterType)
}

final class TTMyDiaryWireFrame: TTBaseWireFrame, TTMyDiaryWireFrameProtocol{
    func navigate(to route: TTMyDiaryRouterType) {
        switch route {
        case .alert(let title, let message):
            break
        case .show(let dateString):
            self.view.show(TTDetailDiaryWireFrame.createModule(dateString: dateString), sender: nil)
            break
            
        }
    }
    
    static func createModule()->TTMyDiaryViewController{
        let view       = UIStoryboard(name: "MyDiary", bundle: nil) .
                            instantiateViewController(withIdentifier: "TTMyDiaryViewController") as! TTMyDiaryViewController
        let wireframe  = TTMyDiaryWireFrame()
        let interactor = TTMyDiaryInteractor()
        let presenter  = TTMyDiaryPresenter(view: view, wireframe: wireframe, interactor: interactor)
        
        view.presenter = presenter
        wireframe.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
