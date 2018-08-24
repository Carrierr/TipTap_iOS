//
//  TTDetailDiaryPresenter.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit

protocol TTDetailDiaryPresenterProtocol: TTBasePresenterProtocol {
    //View->Presenter
    func reloadData()
    
    //UICollectionView
    func didSelectCollectionViewRowAt(indexPath: IndexPath)
    func numberOfRows(in section:Int)->Int
    func numberOfSection()->Int
    func sizeForItem(_ collectionView : UICollectionView, indexPath : IndexPath)->CGSize
    func configureCell(_ collectionView:UICollectionView, forRowAt indexPath : IndexPath)->UICollectionViewCell
}


protocol TTDetailDiaryInteractorOutputProtocol: class {
    //Interactor->Presenter
    func setModuleDatas(_ moduleDatas: [String])
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTDetailDiaryPresenter {
    weak var view : TTDetailDiaryViewProtocol?
    fileprivate var moduleDatas  : [String]?
    fileprivate let wireframe    : TTDetailDiaryWireFrameProtocol
    fileprivate let interactor   : TTDetailDiaryInteractorInputProtocol
    
    init(
        view        : TTDetailDiaryViewProtocol,
        wireframe   : TTDetailDiaryWireFrameProtocol,
        interactor  : TTDetailDiaryInteractorInputProtocol){
        self.view       = view
        self.wireframe  = wireframe
        self.interactor = interactor
    }
}

extension TTDetailDiaryPresenter: TTDetailDiaryPresenterProtocol {
    
    func sizeForItem(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func configureCell(_ collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell : TTDetailImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTDetailImageCell", for: indexPath) as! TTDetailImageCell
            cell.diaryImageView.image = UIImage(named: "sampleImage.jpeg")
            return cell
        }else{
            let cell : TTDetailTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTDetailTextCell", for: indexPath) as! TTDetailTextCell
            if let content = moduleDatas?[indexPath.row-1] {
                cell.diaryContentLabel.text = content
            }
            return cell
        }
    }
    
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
    
    
    
    func numberOfRows(in section: Int) -> Int {
        if let count = moduleDatas?.count {
            return count
        }
        return 0
    }
    
    func numberOfSection() -> Int {
        return 1
    }

    func moreLoad() {
        
    }
    
    func onViewDidLoad(){
        reloadData()
    }
    
    func reloadData(){
        view?.startNetworking()
        interactor.requestDetailDiaryList()
    }
    
    
    
}


extension TTDetailDiaryPresenter : TTDetailDiaryInteractorOutputProtocol{
    func setModuleDatas(_ moduleDatas: [String]) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    
}
