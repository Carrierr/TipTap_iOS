//
//  TTEditDiaryViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class TTEditDiaryViewController: TTBaseViewController, TTCurrentTimeGettable,TTCurrentLocationGettable,TTCanShowAlert {
    var locationManager : CLLocationManager?
    var location        : CLLocation?
    lazy var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageViewTopConst: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var boardTextView: UITextView!
    @IBOutlet weak var accessoryBottomConst: NSLayoutConstraint!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var travelPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TIPTAP #01"
        
        setupImagePicker()
        setUpLocationManager()
        setupTextView()
        registerNotification()
        setupNavigation()
        setImageView(isHidden: true)
        dateLabel.text = currentTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if boardTextView.text?.count == 0 {
            placeHolderLabel.isHidden = false
        }else{
            placeHolderLabel.isHidden = true
        }
        
    }
    
    
    
    private func setupNavigation(){
        navigationController?.navigationBar.tintColor = UIColor.gray;
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    
    
    
    private func setupImagePicker(){
        imagePicker.delegate   = self
        imagePicker.sourceType = .savedPhotosAlbum
    }
    
    
    
    private func setupTextView(){
        boardTextView.becomeFirstResponder()
        boardTextView.delegate = self
        
    }
    
    
    
    func setUpLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    
    
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:  #selector(onUIKeyboardWillShowNotification(noti:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onUIKeyboardWillHideNotification(noti:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
    
    @objc func onUIKeyboardWillShowNotification(noti : Notification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.accessoryBottomConst.constant = -keyboardHeight
        }
    }
    
    
    @objc func onUIKeyboardWillHideNotification(noti : Notification){
        self.accessoryBottomConst.constant = 0
    }
    

    
    @IBAction func submitDiary(_ sender: Any) {
        guard boardTextView.text.count > 0 else {
            showAlert(title: "", message: "일기 내용을 입력해주세요.")
            return
        }
        
        guard let location = location,
            let locationString = locationLabel.text else {
            showAlert(title: "", message: "위치 정보를 받아오지 못하고 있습니다. 직접 위치를 입력해주세요.")
            return
        }
        let param = ["content":boardTextView.text!,
                     "location":locationString,
                     "latitude":"\(location.coordinate.latitude)",
                     "longitude":"\(location.coordinate.longitude)"
                     ] as [String : Any]
        
        TTAPIManager.sharedManager.requestAPIWithImage("\(TTAPIManager.API_URL)/diary/write", method: .post, parameters: param, uploadImage : travelPicture.image) { (result) in
            print(result)
            self.showAlert(title: "", message: "일기가 등록 되었습니다.") {
                self.dismiss(animated: true, completion: nil)
            }

        }
    }
    
    
    
    @IBAction func pressedPickPhoto(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func pressedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func setImageView(isHidden : Bool){
        if isHidden {
            imageViewHeight.constant = 0
            imageViewTopConst.constant = 0
            travelPicture.isHidden = isHidden
        }else{
            imageViewHeight.constant = 67
            imageViewTopConst.constant = 27
            travelPicture.isHidden = isHidden
        }
    }
}



extension TTEditDiaryViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last
        currentLocation { (address) in
            if address != "" {
                self.locationManager?.stopUpdatingLocation()
            }
            self.locationLabel.text = address
        }
    }
}





extension TTEditDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            travelPicture.image = image
            setImageView(isHidden: false)
        }
        
        dismiss(animated: true, completion: nil)
    }
}




extension TTEditDiaryViewController : UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 0 {
            placeHolderLabel.isHidden = false
        }else{
            placeHolderLabel.isHidden = true
        }
        
        textCountLabel.text = "\(textView.text.count)/800"
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(textView.text.count == 0){
            placeHolderLabel.isHidden = true
        }
        return true;
    }
}
