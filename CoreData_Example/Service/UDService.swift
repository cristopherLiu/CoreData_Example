//
//  UDService.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import Foundation

class UDService {
  
  private enum UserDefaultKey: String {
    case acc = "ACCOUNT"
    case name = "NAME"
    case log = "LOG"
  }
  
  var isLogin: Bool {
    if let _ = acc {
      return true
    }
    return false
  }
  
  var acc: String?{
    set{
      let userDefaults = UserDefaults.standard
      userDefaults.setValue(newValue, forKey: UserDefaultKey.acc.rawValue)
      userDefaults.synchronize()
    }
    get{
      return UserDefaults.standard.string(forKey: UserDefaultKey.acc.rawValue)
    }
  }
  
  var name: String?{
    set{
      let userDefaults = UserDefaults.standard
      userDefaults.setValue(newValue, forKey: UserDefaultKey.name.rawValue)
      userDefaults.synchronize()
    }
    get{
      return UserDefaults.standard.string(forKey: UserDefaultKey.name.rawValue)
    }
  }
  
  var logs: [Log]{
    set{
      do {
        let userDefaults = UserDefaults.standard
        try userDefaults.setObject(newValue, forKey: UserDefaultKey.log.rawValue)
      } catch {
        print(error.localizedDescription)
      }
    }
    get{
      do {
        let userDefaults = UserDefaults.standard
        let list = try userDefaults.getObject(forKey: UserDefaultKey.log.rawValue, castTo: [Log].self)
        return list
      } catch {
        print(error.localizedDescription)
        return []
      }
    }
  }
  
  func clear() {
    resetDefaults()
  }
  
  private func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
      defaults.removeObject(forKey: key)
    }
  }
}
