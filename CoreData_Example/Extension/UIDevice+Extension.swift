//
//  UIDevice+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/27.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIDevice {
  
  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let machine = systemInfo.machine
    let mirror = Mirror(reflecting: machine)  // Swift 2.0
    var identifier = ""
    
    // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
    for child in mirror.children where child.value as? Int8 != 0 {
      identifier.append(String(UnicodeScalar(UInt8(child.value as! Int8))))
    }
    
    return identifier
  }
  
  static var localVersion: String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      return version
    }
    return "no version info"
  }
}
