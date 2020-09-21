//
//  Date+Extension.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/27.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

/**
 日期
 */
extension Date {
  func toString(dateFormat:String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
    let formatter = DateFormatter()
    //    formatter.locale = Locale.init(identifier: "zh_TW")
    formatter.locale = Locale.init(identifier: "zh_Hant_TW")
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: self)
    return date
  }
  
  //  static func - (lhs: Date, rhs: Date) -> TimeInterval {
  //      return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  //  }
  
  static func - (recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
    let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
    let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
    let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
    let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
    let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
    
    return (month: month, day: day, hour: hour, minute: minute, second: second)
  }
}

extension DateFormatter {
  
  static let standardT: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return dateFormatter
  }()
  
  static let standard: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter
  }()
  
  static let yearMonthDay: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
  }()
  
  static let iso8601withFractionalSeconds: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()
  static let iso8601: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    return formatter
  }()
}

extension Date {
  var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }
  
  var endOfDay: Date {
    var components = DateComponents()
    components.day = 1
    components.second = -1
    return Calendar.current.date(byAdding: components, to: startOfDay)!
  }
  
  var startOfMonth: Date {
    let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
    return Calendar.current.date(from: components)!
  }
  
  var endOfMonth: Date {
    var components = DateComponents()
    components.month = 1
    components.second = -1
    return Calendar.current.date(byAdding: components, to: startOfMonth)!
  }
}

extension Date {
  
  var year: Int {
    return Calendar.current.component(.year, from: self)
  }
  
  var month: Int {
    return Calendar.current.component(.month, from: self)
  }
  
  var day: Int {
    return Calendar.current.component(.day, from: self)
  }
}
