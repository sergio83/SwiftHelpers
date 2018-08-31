//
//  UIView+Frame.swift
//  dropoff
//
//  Created by Sergio Cirasa on 4/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    /// X Axis value of UIView.
    @objc
    var x: CGFloat {
        set { self.frame = CGRect(x: _pixelIntegral(newValue),
                                  y: self.y,
                                  width: self.width,
                                  height: self.height)
        }
        get { return self.frame.origin.x }
    }
    
    /// Y Axis value of UIView.
    @objc
    var y: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: _pixelIntegral(newValue),
                                  width: self.width,
                                  height: self.height)
        }
        get { return self.frame.origin.y }
    }
    
    /// Width of view.
    @objc
    var width: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: _pixelIntegral(newValue),
                                  height: self.height)
        }
        get { return self.frame.size.width }
    }
    
    /// Height of view.
    @objc
    var height: CGFloat {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: self.width,
                                  height: _pixelIntegral(newValue))
        }
        get { return self.frame.size.height }
    }
    
    // MARK: - Origin and Size
    /// View's Origin point.
    @objc
    var origin: CGPoint {
        set { self.frame = CGRect(x: _pixelIntegral(newValue.x),
                                  y: _pixelIntegral(newValue.y),
                                  width: self.width,
                                  height: self.height)
        }
        get { return self.frame.origin }
    }
    
    /// View's size.
    @objc
    var size: CGSize {
        set { self.frame = CGRect(x: self.x,
                                  y: self.y,
                                  width: _pixelIntegral(newValue.width),
                                  height: _pixelIntegral(newValue.height))
        }
        get { return self.frame.size }
    }
    
    // MARK: - Extra Properties
    /// View's right side (x + width).
    @objc
    var right: CGFloat {
        set { self.x = newValue - self.width }
        get { return self.x + self.width }
    }
    
    /// View's bottom (y + height).
    @objc
    var bottom: CGFloat {
        set { self.y = newValue - self.height }
        get { return self.y + self.height }
    }
    
    /// View's top (y).
    @objc
    var top: CGFloat {
        set { self.y = newValue }
        get { return self.y }
    }
    
    /// View's left side (x).
    @objc
    var left: CGFloat {
        set { self.x = newValue }
        get { return self.x }
    }
    
    /// View's center X value (center.x).
    @objc
    var centerX: CGFloat {
        set { self.center = CGPoint(x: newValue, y: self.centerY) }
        get { return self.center.x }
    }
    
    /// View's center Y value (center.y).
    @objc
    var centerY: CGFloat {
        set { self.center = CGPoint(x: self.centerX, y: newValue) }
        get { return self.center.y }
    }
    
    fileprivate func _pixelIntegral(_ pointValue: CGFloat) -> CGFloat {
        let scale = UIScreen.main.scale
        return (round(pointValue * scale) / scale)
    }
}
