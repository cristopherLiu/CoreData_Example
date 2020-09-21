//
//  MyTextfield.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UITextField{
  
  @IBInspectable var doneAccessory: Bool{
    get{
      return self.doneAccessory
    }
    set (hasDone) {
      if hasDone{
        addDoneButtonOnKeyboard()
      }
    }
  }
  
  func addDoneButtonOnKeyboard() {
    
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(self.doneButtonAction))
    done.tintColor = UIColor.bk
    
    if #available(iOS 13.0, *) {
      if UITraitCollection.current.userInterfaceStyle == .dark {
        done.tintColor = UIColor.w
      }
    }
    
    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    self.inputAccessoryView = doneToolbar
  }
  
  @objc func doneButtonAction()
  {
    self.resignFirstResponder()
  }
}
