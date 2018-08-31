//
//  UIFontExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 17/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation

import UIKit

extension UIFont {
    
    public static func printAllFonts(){
        UIFont.familyNames.forEach({ familyName in
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        print(familyName, fontNames)
        })
    }
}

