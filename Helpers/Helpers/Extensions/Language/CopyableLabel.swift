//
//  CopyableLabel.swift
//  dropoff
//
//  Created by Jason Kastner on 4/5/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

class CopyableLabel: UILabel {
  override public var canBecomeFirstResponder: Bool {
    get {
      return true
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func sharedInit() {
    isUserInteractionEnabled = true
    addGestureRecognizer(UILongPressGestureRecognizer(
      target: self,
      action: #selector(showMenu(sender:))
    ))
  }
  
  override func copy(_ sender: Any?) {
    UIPasteboard.general.string = text
    UIMenuController.shared.setMenuVisible(false, animated: true)
  }
  
  @objc func showMenu(sender: Any?) {
    becomeFirstResponder()
    let menu = UIMenuController.shared
    if !menu.isMenuVisible {
      menu.setTargetRect(CGRectFromString("{{0,0},{50,20}}"), in: self)
      menu.setMenuVisible(true, animated: true)
    }
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return (action == #selector(copy(_:)))
  }
}
