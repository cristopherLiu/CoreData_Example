//
//  Data+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/27.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation
import CommonCrypto

/**
 檔案
 */
extension Data {
  
  var hexString: String {
    return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
  }
  
  var size: String {
    let bcf = ByteCountFormatter()
    bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
    bcf.countStyle = .file
    let string = bcf.string(fromByteCount: Int64(self.count))
    return string
  }
  
  var sha256: Data {
    
    /// Creates an array of unsigned 8 bit integers that contains 32 zeros
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    self.withUnsafeBytes({
      _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &digest)
    })
    
    return Data(bytes: digest)
  }
}

extension Data {
  
  struct HexEncodingOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
  }
  
  func hexEncodedString(options: HexEncodingOptions = []) -> String {
    let hexDigits = Array((options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef").utf16)
    var chars: [unichar] = []
    chars.reserveCapacity(2 * count)
    for byte in self {
      chars.append(hexDigits[Int(byte / 16)])
      chars.append(hexDigits[Int(byte % 16)])
    }
    return String(utf16CodeUnits: chars, count: chars.count)
  }
}

