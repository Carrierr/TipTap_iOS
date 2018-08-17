//
//  TTBaseWireFrame.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

enum TTTransitionType {
    //    case root(window: UIWindow)
    case push
    case present(from: UIViewController)
}


class TTBaseWireFrame:NSObject{
    weak var view: UIViewController!
    
    func show(_ viewController: UIViewController,with type : TTTransitionType, animated:Bool = true){
        switch type {
        case .push:
            guard let navigationController = view.navigationController else {
                fatalError("Can't push without a navigation controller")
            }
            navigationController.pushViewController(viewController, animated: true)
            break
            
        case .present(let sender):
            sender.present(viewController, animated: true, completion: nil)
            break
        }
    }
}

