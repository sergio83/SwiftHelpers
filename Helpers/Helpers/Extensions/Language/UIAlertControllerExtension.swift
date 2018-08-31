//
//  UIAlertControllerExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 31/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    public static func showAlert(message:String, presenter:UIViewController, handler: ((UIAlertAction) -> Swift.Void)? = nil){
        let alert = UIAlertController(title: nil , message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(ok)
        presenter.present(alert, animated: true, completion: nil)
    }
    
    public static func showNoInternetConnectionAlert(presenter:UIViewController, handler: ((UIAlertAction) -> Swift.Void)? = nil){
        let alert = UIAlertController(title: nil , message: "You are not connected to the Internet. Please check your settings.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(ok)
        presenter.present(alert, animated: true, completion: nil)
    }
    
    public static func showUnExpectedErrorAlert(presenter:UIViewController, handler: ((UIAlertAction) -> Swift.Void)? = nil){
        let alert = UIAlertController(title: "Oops" , message: "Something went wrong.\nPlease try again in a moment.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler) 
        alert.addAction(ok)
        presenter.present(alert, animated: true, completion: nil)
    }
    
}

