//
//  UILabelExtension.swift
//  dropoff
//
//  Created by sergio on 24/8/18.
//  Copyright © 2018 Dropoff. All rights reserved.
//

import Foundation

extension UILabel{
    func isEmpty() -> Bool{
        if self.text == nil || self.text!.count == 0{
            return true
        }
        return false
    }
}
