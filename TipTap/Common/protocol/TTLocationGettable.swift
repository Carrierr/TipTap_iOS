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
import MapKit

protocol TTLocationGettable{
    var locationManager : CLLocationManager? { get set }
    var location        : CLLocation?  { get set }
    
    func currentLocation(completion: @escaping (String) -> ())
    func setUpLocationManager()
}

extension TTLocationGettable{
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
    
    func getLocations(withKeyword keyword:String){
        
        guard let location = location else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = keyword
        request.region               = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, _) in
            guard let response = response else { return }
            print("search List : \(response)")
        }
    }
}
