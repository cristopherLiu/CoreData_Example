//
//  MyImage.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/4.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIImage {
  
  func resize(width: CGFloat, height: CGFloat) -> UIImage {
    
    let size = self.size
    let widthRatio  = width  / size.width
    let heightRatio = height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}

extension UIImage {
  
  func maskWithColor(color: UIColor) -> UIImage? {
    let maskImage = cgImage!
    
    let width = size.width
    let height = size.height
    let bounds = CGRect(x: 0, y: 0, width: width, height: height)
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
    
    context.clip(to: bounds, mask: maskImage)
    context.setFillColor(color.cgColor)
    context.fill(bounds)
    
    if let cgImage = context.makeImage() {
      let coloredImage = UIImage(cgImage: cgImage)
      return coloredImage
    } else {
      return nil
    }
  }
}

extension UIImage {
  
  func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
    
    let width: CGFloat = size.width + x
    let height: CGFloat = size.height + y
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
    let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
    draw(at: origin)
    let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imageWithPadding
  }
}
