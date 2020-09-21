//
//  MyCell.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/5.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

public extension UITableViewCell {
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UICollectionViewCell{
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UITableViewHeaderFooterView{
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}
