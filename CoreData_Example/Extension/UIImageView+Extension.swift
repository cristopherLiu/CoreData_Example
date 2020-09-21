//
//  UIImageView+Extension.swift
//  MyCode
//
//  Created by 劉紘任 on 2020/5/18.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIImageView {
  
//  func downloaded(from url: URL, defaultImage: UIImage?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//    
//    contentMode = mode
//    NetworkService.sharedInstance.downloadImage(url: url) { (image) in
//      DispatchQueue.main.async() {
//        self.image = image != nil ? image : defaultImage
//      }
//    }
//    
//    //    contentMode = mode
//    //    URLSession.shared.dataTask(with: url) { data, response, error in
//    //
//    //      guard
//    //        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//    //        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//    //        let data = data, error == nil,
//    //        let image = UIImage(data: data)
//    //        else { return }
//    //      DispatchQueue.main.async() {
//    //        self.image = image
//    //      }
//    //    }.resume()
//  }
//  
//  func downloaded(from link: String, defaultImage: UIImage?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//    
//    guard let url = URL(string: link) else { return }
//    downloaded(from: url, defaultImage: defaultImage, contentMode: contentMode)
//  }
}
