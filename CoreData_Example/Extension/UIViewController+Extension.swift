//
//  UIViewController+EXTENSION.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//

import UIKit

extension UIViewController {
  
  /**
   *  Height of status bar + navigation bar (if navigation bar exist)
   */
  
  var topbarHeight: CGFloat {
    return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
      (self.navigationController?.navigationBar.frame.height ?? 0.0)
  }
}
