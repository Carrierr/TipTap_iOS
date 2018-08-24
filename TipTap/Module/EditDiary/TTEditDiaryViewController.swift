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
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var travelPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        setUpLocationManager()
        title = "TIPTAP #01"
        dateLabel.text = currentTime()
    }

    private func setupImagePicker(){
        imagePicker.delegate   = self
        imagePicker.sourceType = .savedPhotosAlbum
    }
    
    func setUpLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
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
