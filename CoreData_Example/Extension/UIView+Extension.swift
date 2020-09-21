//
//  MyView.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/4.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundCorners(corners: UIRectCorner = .allCorners, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  //  func roundCorners(radius: CGFloat) {
  //    self.layer.cornerRadius = radius
  //    self.clipsToBounds = true
  //  }
}

extension UIView {
  
  fileprivate struct AssociatedObjectKeys {
    static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
  }
  
  fileprivate typealias Action = (() -> Void)?
  
  fileprivate var tapGestureRecognizerAction: Action? {
    set {
      if let newValue = newValue {
        // Computed properties get stored as associated objects
        objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      }
    }
    get {
      let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
      return tapGestureRecognizerActionInstance
    }
  }
  
  
  public func addTapGestureRecognizer(action: (() -> Void)?) {
    self.isUserInteractionEnabled = true
    self.tapGestureRecognizerAction = action
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
    if let action = self.tapGestureRecognizerAction {
      action?()
    } else {
      print("no action")
    }
  }
}


extension UIView {
  var screenShot: UIImage?  {
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
    if let context = UIGraphicsGetCurrentContext() {
      layer.render(in: context)
      let screenshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return screenshot
    }
    return nil
  }
}
