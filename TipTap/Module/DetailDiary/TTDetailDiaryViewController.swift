//
//  TTDetailDiaryViewController.swift
//  TipTap
//
//  Created by JHH on 2018. 8. 17..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

protocol TTDetailDiaryViewProtocol:class{
    func startNetworking()
    func stopNetworking()
}

class TTDetailDiaryViewController: TTBaseViewController {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter:TTDetailDiaryPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func setupNavigaion(){
        let rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(pressedDeleteButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    override func setupUI() {
        setupNavigaion()
        registerCell()
        brandLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
    }
    
    override func setupBinding() {
        
    }
    
    func registerCell(){
        self.collectionView?.register(UINib(nibName: "TTDetailDiaryCell", bundle: nil), forCellWithReuseIdentifier: "TTDetailDiaryCell")
    }
    
    @objc private func pressedDeleteButton(){
        
    }
}

extension TTDetailDiaryViewController: TTDetailDiaryViewProtocol {
    func startNetworking() {
        self.collectionView.reloadData()
    }
    
    func stopNetworking() {
        self.collectionView.reloadData()
    }
    
}



extension TTDetailDiaryViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCollectionViewRowAt(indexPath: indexPath)
    }
}



extension TTDetailDiaryViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (presenter?.sizeForItem(collectionView, indexPath: indexPath))!
    }
}



extension TTDetailDiaryViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.numberOfRows(in: section))!
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (presenter?.numberOfSection())!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (presenter?.configureCell(collectionView, forRowAt: indexPath))!
    }
}


