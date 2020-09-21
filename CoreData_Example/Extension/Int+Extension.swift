//
//  Int+Extension.swift
//  VillageActivity
//
//  Created by hjliu on 2020/9/1.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

extension Int {
  
  var boolValue: Bool { return self != 0 }
  
  // 10進制轉2進制
  var toBinary: String {
    return String(self, radix: 2, uppercase: true)
  }
  // 10進制轉16進制
  var toHexa: String {
    return String(self, radix: 16)
  }
}
