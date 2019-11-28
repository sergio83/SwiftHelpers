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
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidShowNotification), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func onKeyboardDidShowNotification(notification: Notification){
        if let scrollView = scrollViewToAdjustInset(), let info = notification.userInfo {
            if let keyboardRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue{
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
