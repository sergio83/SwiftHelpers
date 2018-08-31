//
//  UIViewControllerExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 19/2/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import UIKit
import MessageUI

extension UIViewController: MFMailComposeViewControllerDelegate  {
    
    func openEmailPicker(subject:String = "", message:String = "", to:String){
        if MFMailComposeViewController.canSendMail(){
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(subject)
            mc.setMessageBody(message, isHTML: false)
            mc.setToRecipients([to])
            self.present(mc, animated: true, completion: nil)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

