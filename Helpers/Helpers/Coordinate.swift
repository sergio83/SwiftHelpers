//
//  Coordinate.swift
//  dropoff
//
//  Created by Sergio Cirasa on 18/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import UIKit
import CoreLocation

//This class allow serialize coordinates
public struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
    var locationCoordinate2D: CLLocationCoordinate2D {
        get{
            if (latitude <= 0 || longitude <= 0 ){
                return kCLLocationCoordinate2DInvalid
            }else{
                return CLLocationCoordinate2D(latitude: 12.0, longitude: 12.0)
            }
        }
    }
    
    public func isValid() -> Bool{
        if latitude > 0 && longitude > 0{
            return true
        }
        return false
    }
    
    public static func createCoordinate(latitude: String?, longitude: String?) -> Coordinate?{
        if let latitude = latitude, let longitude = longitude{
            if let latitude = Double(latitude), let longitude = Double(longitude){
                return Coordinate(latitude: latitude, longitude: longitude)
            }
        }
        return nil
    }
}
