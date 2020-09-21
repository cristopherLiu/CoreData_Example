//
//  UIApplication+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/25.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

public extension UIApplication {
  
  class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    
    if let tab = base as? UITabBarController {
      let moreNavigationController = tab.moreNavigationController
      
      if let top = moreNavigationController.topViewController, top.view.window != nil {
        return topViewController(top)
      } else if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    
    return base
  }
  
  var statusBarView: UIView? {
    return value(forKey: "statusBar") as? UIView
  }
}
