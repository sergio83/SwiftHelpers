//
//  UIViewLoader.swift
//  dropoff
//
//  Created by Sergio Cirasa on 31/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

extension UIView{

    private struct ToastKeys {
        static var activeToasts = "com.toast-swift.activeToasts"
    }
    
    private var activeToasts: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &ToastKeys.activeToasts) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self, &ToastKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }
    
    func showLoader(){
        
        let container = createToastActivityView()
        container.alpha = 0.0
        //     toast.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addSubview(container)
        
        
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: container, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: container, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        if #available(iOS 11, *) {
            let guide = self.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 0.0),
                guide.bottomAnchor.constraint(equalToSystemSpacingBelow: container.bottomAnchor, multiplier: 0.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 0.0
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: self.topAnchor, constant: standardSpacing),
                self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: standardSpacing)
                ])
        }
        
        
        activeToasts.add(container)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            container.alpha = 1.0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0, execute: {
            self.hideLoader()
        })
    }
    
    func hideLoader(){
        guard let activeToast = activeToasts.firstObject as? UIView else { return }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
            activeToast.alpha = 0.0
        }) { _ in
            activeToast.removeFromSuperview()
            self.activeToasts.remove(activeToast)
        }
    }
    
    private func createToastActivityView() -> UIView {
        
        let container = UIView(frame: self.bounds)
        container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.center = CGPoint(x: container.bounds.size.width / 2.0, y: container.bounds.size.height / 2.0)
        container.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        return container
    }
    
}
