//
//  UIViewController+Keyboard.swift
//  dropoff
//
//  Created by Sergio Cirasa on 3/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func registerKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidShowNotification), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
    }
    
    public func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc public func onKeyboardDidShowNotification(notification: Notification){
        if let scrollView = scrollViewToAdjustInset(), let info = notification.userInfo {
            if let keyboardRect = (info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue{
                let rect = scrollView.convert(keyboardRect, from: nil)
                var contentInset = scrollView.contentInset
                contentInset.bottom = rect.size.height + 10
               scrollView.contentInset = contentInset              
            }
        }
    }
    
    @objc public func onKeyboardWillBeHidden(notification: Notification){
        if let scrollView = scrollViewToAdjustInset() {
            scrollView.contentInset = self.defaultContentInset()
        }
    }
    
    @objc public func scrollViewToAdjustInset() -> UIScrollView?{
        return nil
    }
    
    @objc public func defaultContentInset() -> UIEdgeInsets{
        return .zero
    }
        
}
