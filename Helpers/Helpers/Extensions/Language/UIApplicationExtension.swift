//
//  UIApplicationExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 4/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func applicationVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        return dictionary["CFBundleShortVersionString"] as! String
    }
    
    static func applicationBuild() -> String {
        let dictionary = Bundle.main.infoDictionary!
        return dictionary["CFBundleVersion"] as! String
    }

    static func firstExecution() -> Bool {
        if UserDefaults.standard.object(forKey: "FirstTime") != nil{
            return false
        }else{
            UserDefaults.standard.set(false, forKey: "FirstTime")
            UserDefaults.standard.synchronize()
            return true
        }
    }
}

