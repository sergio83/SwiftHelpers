//
//  UITableViewCellExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 3/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    @IBInspectable var selectedColor : UIColor {
        set {
            let bgColorView = UIView()
            bgColorView.backgroundColor = newValue
            self.selectedBackgroundView = bgColorView
        }
        get {
            if let v = self.selectedBackgroundView, let color = v.backgroundColor{
                return color
            }else{
                return UIColor.white
            }
        }
    }
    
}


