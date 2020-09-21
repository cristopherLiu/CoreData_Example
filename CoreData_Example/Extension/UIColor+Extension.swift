//
//  MyColor.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/4.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
  
  func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
    
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    
    let context = UIGraphicsGetCurrentContext()
    
    self.setFill()
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
}

//extension UIColor {
//  
//  static let pri = UIColor(rgb: 0x28C8C8)
//  static let pri_5 = UIColor(rgb: 0x28C8C8).withAlphaComponent(0.5)
//  
//  static let dan = UIColor(rgb: 0xFF9C33)
//  static let dan_5 = UIColor(rgb: 0xFF9C33).withAlphaComponent(0.5)
//  
//  static let imp = UIColor(rgb: 0xFF435E)
//  
//  static let bk = UIColor(rgb: 0x393939)
//  static let bk_8 = UIColor(rgb: 0x393939).withAlphaComponent(0.8)
//  static let bk_5 = UIColor(rgb: 0x393939).withAlphaComponent(0.5)
//  static let bk_3 = UIColor(rgb: 0x393939).withAlphaComponent(0.3)
//  static let bk_1 = UIColor(rgb: 0x393939).withAlphaComponent(0.1)
//  
//  static let w = UIColor(rgb: 0xffffff)
//  static let w_8 = UIColor(rgb: 0xffffff).withAlphaComponent(0.8)
//  static let w_5 = UIColor(rgb: 0xffffff).withAlphaComponent(0.5)
//  static let w_3 = UIColor(rgb: 0xffffff).withAlphaComponent(0.3)
//  
//  static let gy = UIColor(rgb: 0xEBEBEB)
//}
