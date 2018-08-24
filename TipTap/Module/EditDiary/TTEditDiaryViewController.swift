//
//  TTEditDiaryViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import CoreLocation

class TTEditDiaryViewController: TTBaseViewController, TTCurrentTimeGettable,TTCurrentLocationGettable {
    var locationManager : CLLocationManager?
    var location        : CLLocation?
    lazy var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var boardTextView: UITextView!
    @IBOutlet weak var accessoryBottomConst: NSLayoutConstraint!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var travelPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        setUpLocationManager()
        title = "TIPTAP #01"
        dateLabel.text = currentTime()
        setupTextView()
        registerNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if boardTextView.text?.count == 0 {
            placeHolderLabel.isHidden = false
        }else{
            placeHolderLabel.isHidden = true
        }
        
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
    
    
    @IBAction func pressedPickPhoto(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
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
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(textView.text.count == 0){
            placeHolderLabel.isHidden = true
        }
        return true;
    }
}
