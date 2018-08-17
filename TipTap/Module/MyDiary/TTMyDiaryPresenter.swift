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
    
    //CollectionView
    func didSelectCollectionViewRowAt(indexPath: IndexPath)
    func numberOfRows(in section:Int)->Int
    func numberOfSection()->Int
    func sizeForItemAt(viewSize : CGSize, indexPath: IndexPath)->CGSize
    func sizeHeaderForItemAt(viewSize : CGSize, section: Int)->CGSize
    func configureCell(_ collectionView:UICollectionView, forRowAt indexPath : IndexPath)->UICollectionViewCell
    func configureHeaderCell(headerView:UICollectionReusableView, indexPath : IndexPath)->UICollectionReusableView
}


protocol TTMyDiaryInteractorOutputProtocol: class {
    //Interactor->Presenter
    func setModuleDatas(_ moduleDatas: [String])
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTMyDiaryPresenter {
    weak var view : TTMyDiaryViewProtocol?
    fileprivate var moduleDatas  : [String]?
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

extension TTMyDiaryPresenter: TTMyDiaryPresenterProtocol {
    func moreLoad() {
        
    }
    
    func onViewDidLoad(){
        reloadData()
    }
    
    func reloadData(){
        view?.startNetworking()
        interactor.requestMyDiaryList()
    }
    
    
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        print("select index : \(indexPath.row)")
    }
    
    func numberOfRows(in section: Int) -> Int {
        <#code#>
    }
    
    func numberOfSection() -> Int {
        <#code#>
    }
    
    func sizeForItemAt(viewSize: CGSize, indexPath: IndexPath) -> CGSize {
        <#code#>
    }
    
    func sizeHeaderForItemAt(viewSize: CGSize, section: Int) -> CGSize {
        <#code#>
    }
    
    func configureCell(_ collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func configureHeaderCell(headerView: UICollectionReusableView, indexPath: IndexPath) -> UICollectionReusableView {
        <#code#>
    }
}


extension TTMyDiaryPresenter : TTMyDiaryInteractorOutputProtocol{
    func setModuleDatas(_ moduleDatas: [String]) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    
}
