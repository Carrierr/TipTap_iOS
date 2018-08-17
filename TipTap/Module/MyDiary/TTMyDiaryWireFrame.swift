//
//  TTMyDiaryWireFrame.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

enum TTMyDiaryRouterType{
    case show(item: [String])
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
        case .show(let item):
            break
            
        }
    }
    
    static func createModule()->TTMyDiaryViewController{
        let view       = TTMyDiaryViewController()
        let wireframe  = TTMyDiaryWireFrame()
        let interactor = TTMyDiaryInteractor()
        let presenter  = TTMyDiaryPresenter(view: view, wireframe: wireframe, interactor: interactor)
        
        view.presenter = presenter
        
        
        
        
    }
    
}
