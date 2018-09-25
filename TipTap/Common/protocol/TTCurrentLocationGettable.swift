//
//  TTCurrentLocationGettable.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 18..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol TTCurrentLocationGettable{
    var locationManager : CLLocationManager? { get set }
    var location        : CLLocation?  { get set }
    
    func currentLocation(completion: @escaping (String) -> ())
    func setUpLocationManager()
}

extension TTCurrentLocationGettable{
    func currentLocation(completion: @escaping (String) -> ()){
        guard let location = location else {
            completion("")
            return
        }
        let geoCorder = CLGeocoder()
        geoCorder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if error != nil {
                print("Geocode failed with error : \(error.debugDescription)")
                completion("")
                return
            }

            
            if let placemark = placeMarks?[0] {
                print("isoCountryCode : \(placemark.isoCountryCode ?? "")")
                print("country : \(placemark.country ?? "")")
                print("postalCode : \(placemark.postalCode ?? "")")
                print("administrativeArea : \(placemark.administrativeArea ?? "")")
                print("locality : \(placemark.locality ?? "")")
                print("subLocality : \(placemark.subLocality ?? "")")
                print("subThoroughfare : \(placemark.subThoroughfare ?? "")")
                completion("\(placemark.administrativeArea ?? "") \(placemark.locality ?? "") \(placemark.subLocality ?? "") \(placemark.subThoroughfare ?? "")")
            }
        }
    }
}
