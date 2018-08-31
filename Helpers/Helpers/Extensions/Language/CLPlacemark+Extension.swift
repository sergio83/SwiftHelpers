//
//  CLPlacemark+Extension.swift
//  dropoff
//
//  Created by sergio on 15/8/18.
//  Copyright © 2018 Dropoff. All rights reserved.
//

import Foundation
import CoreLocation

extension CLPlacemark{
    
    func formattedAddressLines() -> String{
        var address = ""
        
        if let thoroughfare = self.thoroughfare{
            if let subThoroughfare = self.subThoroughfare{
                address = "\(address)\(subThoroughfare)"
            }
            
             address = "\(address) \(thoroughfare)"
        }

        if let locality = self.locality{
            if address.count > 0{
                address = "\(address), "
            }
            
            address = "\(address)\(locality)"
        }
        
        if let administrativeArea = self.administrativeArea{
            if address.count > 0{
                address = "\(address), "
            }
            
            address = "\(address)\(administrativeArea)"
        }
        
        if let postalCode = self.postalCode{
            if address.count > 0{
                address = "\(address), "
            }
            
            address = "\(address)\(postalCode)"
        }
        
        if let country = self.country{
            if address.count > 0{
                address = "\(address), "
            }
            
            address = "\(address)\(country)"
        }
        
        return address
    }
    
}
