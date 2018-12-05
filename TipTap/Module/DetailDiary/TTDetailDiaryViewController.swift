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
    func dismissView()
}

class TTDetailDiaryViewController: TTBaseViewController ,TTCanShowAlert, TTTimeGettable{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    
    var presenter:TTDetailDiaryPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        NotificationCenter.default.post(name: Notification.Name.ablePaging.changedDisablePaging, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    deinit {
        NotificationCenter.default.post(name: Notification.Name.ablePaging.changedAblePaging, object: nil)
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func setupNavigaion(){
        let rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(pressedDeleteButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backwhite")
        navigationController?.navigationBar.topItem?.title = "";
    }
    
    override func setupUI() {
        setupNavigaion()
        registerCell()
        titleLabel.text = "MY DIARY\n#1"
        brandLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
    }
    
    
    
    override func setupBinding() {
        
    }
    
    
    
    func registerCell(){
        self.collectionView?.register(UINib(nibName: "TTDetailDiaryCell", bundle: nil), forCellWithReuseIdentifier: "TTDetailDiaryCell")
    }
    
    
    fileprivate func setupDateLabel(){
        guard let dateString = presenter?.dateString(section: 0) else { return }
        let month = convertMonthString(month: Int(dateConvert(dateString: presenter?.dateString(section: 0) ?? "", format: "MM")) ?? 0 )
        let day = dateConvert(dateString: dateString, format: "dd")
        yearLabel.text = "\(dateConvert(dateString: dateString, format: "yy"))`"
        DateLabel.text = "\(month)\n\(day)"
    }
    
    
    @objc private func pressedDeleteButton(){
        showAlert(title: "", message: "일기를 삭제하시겠습니까?", completion: {
            self.presenter?.deleteDiary()
        }, cancelAction: {
            
        })
    }
    
    
    @objc internal func dismissView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in self.collectionView.visibleCells {
            let indexPath = self.collectionView.indexPath(for: cell)
            locationLabel.text = presenter!.locationString(section:indexPath?.section ?? 0)
            titleLabel.text = "MY DIARY\n#\((indexPath?.section ?? 1) + 1)"
        }
    }
}



extension TTDetailDiaryViewController: TTDetailDiaryViewProtocol {
    func startNetworking() {
        self.collectionView.reloadData()
        
    }
    
    
    func stopNetworking() {
        self.collectionView.reloadData()
        setupDateLabel()
        locationLabel.text = presenter!.locationString(section:0)
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


