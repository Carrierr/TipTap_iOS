//
//  TTDetailDiaryPresenter.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


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
    func setModuleDatas(_ moduleDatas: [TTDiaryData])
    func didReceivedError(_ error: Error)
    func showMessage(message : String)
}


final class TTDetailDiaryPresenter {
    weak var view : TTDetailDiaryViewProtocol?
    fileprivate var moduleDatas  : [TTDiaryData]?
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
        
        guard let contentData = moduleDatas?[indexPath.section] else {
            return UICollectionViewCell()
        }
        
        let cell : TTDetailDiaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTDetailDiaryCell", for: indexPath) as! TTDetailDiaryCell
        
        if indexPath.row == 0 {
            if let imageURL = contentData.imageUrl{
                cell.diaryImageView.kf.setImage(with: imageURL)
                cell.diaryImageView.isHidden    = false
                cell.diaryContentLabel.isHidden = true
            }else{
                cell.diaryContentLabel.text = contentData.content!
                cell.diaryContentLabel.isHidden = false
                cell.diaryImageView.isHidden 	= true
            }
        }else{
            cell.diaryContentLabel.text      = contentData.content!
            cell.diaryContentLabel.isHidden  = false
            cell.diaryImageView.isHidden     = true
        }
        return cell
    }
    
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
    
    
    
    func numberOfRows(in section: Int) -> Int {
        guard let datas = moduleDatas?[section] else { return 0 }
        if ((datas.imageUrl) != nil) {
            return 2
        }
        return 1
    }
    
    
    
    func numberOfSection() -> Int {
        guard let count = moduleDatas?.count else {
            return 0
        }
        return count
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
    func setModuleDatas(_ moduleDatas: [TTDiaryData]) {
        self.moduleDatas = moduleDatas
        view?.startNetworking()
    }
    
    func didReceivedError(_ error: Error) {
        
    }
    
    func showMessage(message: String) {
        
    }
}
