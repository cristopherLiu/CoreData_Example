//
//  TextCellViewModel.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import Foundation

class TextCellViewModel {
  let name: String
  let text: String
  var time: Date
  
  init(name: String, text: String, time: Date) {
    self.name = name
    self.text = text
    self.time = time
  }
}
