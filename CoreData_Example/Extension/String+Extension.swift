//
//  String+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/27.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit
import CoreImage.CIFilterBuiltins

/**
 字串
 */
extension String {
  
  func sha256(salt: String) -> Data? {
    
    if let inputData = (self + salt).data(using: String.Encoding.utf8) {
      
      //      if #available(iOS 13.0, *) {
      //        return SHA256.hash(data: inputData)
      //      } else {
      //        return inputData.sha256
      //      }
      return inputData.sha256
    }
    return nil
  }
  
  func fromBase64() -> String? {
    guard let data = Data(base64Encoded: self) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }
  
  func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }
  
  func toDate(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from: self)
    return date
  }
  
  func encodeUrl() -> String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
  }
  
  func decodeUrl() -> String? {
    return self.removingPercentEncoding
  }
  
  func isAllDigits()->Bool {
    let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = self.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    return  self == filtered
  }
}

extension String {
  // 多國語系
  func localized(withComment comment: String? = nil) -> String {
    return NSLocalizedString(self, comment: comment ?? "")
  }
  
  func localized(with arguments: [CVarArg], comment: String? = nil) -> String {
    return String(format: self.localized(withComment: comment), locale: nil, arguments: arguments)
  }
}

extension String {
  
  // 產生Qrcode
  func generateQRCode() -> UIImage? {
    
    // 轉換成data
    guard let data = self.data(using: String.Encoding.ascii) else {return nil}
    
    // QR CIFilter
    //    let qrFilter = CIFilter.qrCodeGenerator()
    //    qrFilter.message = data
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    qrFilter.setValue(data, forKey: "inputMessage")
    guard let qrImage = qrFilter.outputImage else { return nil }
    
    // 放大
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQrImage = qrImage.transformed(by: transform)
    
    return UIImage(ciImage: scaledQrImage)
  }
}

extension String {
  // 16進制轉10進制
  var hexaToDecimal: Int {
    return Int(strtoul(self, nil, 16))
  }
  // 16進制轉2進制
  var hexaToBinary: String {
    return hexaToDecimal.toBinary
  }
  // 2進制轉10進制
  var binaryToDecimal: Int {
    return Int(strtoul(self, nil, 2))
  }
  // 2進制轉16進制
  var binaryToHexa: String {
    return binaryToDecimal.toHexa
  }
}

extension String {
  
  // 移除最後Ｘ位數字
  mutating func removeCharsFromEnd(removeCount: Int) -> String {
    let stringLength = self.count // 字串長
    let offsetIndex = max(0, stringLength - removeCount) // 剩餘長度
    let index = self.index(self.startIndex, offsetBy: offsetIndex)
    let drop = String(self[index..<self.endIndex]) // 捨去的字串
    self = String(self[..<index]) // 變更原有字串
    return drop
  }
  
  // 台北卡16進位字串
  var taipeiCardHexString: String {
    
    var orignalStr = self
    
    // 補滿八位數
    while orignalStr.count < 8 {
      orignalStr.insert("0", at: orignalStr.startIndex)
    }
    
    var results = [String]()
    
    for _ in 1...4 {
      let drop = orignalStr.removeCharsFromEnd(removeCount: 2)
      results.append(drop)
    }
    return results.joined()
  }
}
