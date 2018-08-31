//
//  UIViewExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 3/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import UIKit
import QuartzCore

//@IBDesignable
extension UIView {
    
    @IBInspectable var shadowRadius : CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity : CGFloat {
        set {
            layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(layer.shadowOpacity)
        }
    }
    
    @IBInspectable var shadowColor : UIColor? {
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            }
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }else{
                return nil
            }
        }
    }
    
    @IBInspectable var shadowOffset : CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return  layer.shadowOffset
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            }
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }else{
                return nil
            }
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
    
    func removeSubviewsAndHide(){
        _ = self.subviews.map { $0.removeFromSuperview() }
      //  self.isHidden = true
        self.height = 0
        self.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
}

