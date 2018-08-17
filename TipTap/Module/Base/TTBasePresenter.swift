//
//  TTBasePresenter.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation

protocol TTBasePresenterProtocol: class {
    func onViewDidLoad()
    func moreLoad()
}

extension TTBasePresenterProtocol{
    func onViewDidLoad(){ }
}
