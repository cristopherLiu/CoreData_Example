//
//  UILabel+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/30.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UILabel {
  
  // 行間距
  // Pass value for any one of both parameters and see result
  func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
    
    guard let labelText = self.text else { return }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    paragraphStyle.alignment = self.textAlignment
    
    let attributedString: NSMutableAttributedString
    if let labelattributedText = self.attributedText {
      attributedString = NSMutableAttributedString(attributedString: labelattributedText)
    } else {
      attributedString = NSMutableAttributedString(string: labelText)
    }
    
    // Line spacing attribute
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
    
    self.attributedText = attributedString
  }
  
//  func setLineHeight(lineSpacing: CGFloat) {
//    
//    guard let labelText = self.text else { return }
//    
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineSpacing = lineSpacing
//    paragraphStyle.alignment = self.textAlignment
//    
//    let attributedString = NSMutableAttributedString(string: labelText)
//
//    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
//
//    self.attributedText = attributedString
//  }
}
