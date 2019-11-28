//
//  CLLocationCoordinate2DExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 9/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLLocationCoordinate2D {
    
    static func createLocationCoordinate2D(latitude: String?, longitude: String?) -> CLLocationCoordinate2D{
        if let latitude = latitude, let longitude = longitude{
            if let latitude = Double(latitude), let longitude = Double(longitude){
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        return kCLLocationCoordinate2DInvalid
    }
    
}


