//
//  UITextFieldExtension.swift
//  dropoff
//
//  Created by sergio on 29/6/18.
//  Copyright © 2018 Dropoff. All rights reserved.
//

import Foundation

extension UITextField{
    
    @IBInspectable var showBottomBorder : Bool {
        set {
            if newValue{
                self.borderStyle = .none
                self.layer.backgroundColor = UIColor.white.cgColor
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha: 1.0).cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 0.0
            }else{
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0.0
            }
        }
        get {
            return false
        }
    }
    
    func setErrorStyle(){
         self.layer.shadowColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
    }
    
    func setDefaultStyle(){
         self.layer.shadowColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha: 1.0).cgColor
    }
    
    func isEmpty() -> Bool{
        if self.text == nil || self.text!.count == 0{
            return true
        }
        return false
    }
    
}
