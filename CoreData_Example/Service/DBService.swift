//
//  DBService.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/18.
//

import UIKit
import CoreData

class DBService {
  
  //獲取管理的上下文
  private var context: NSManagedObjectContext {
    let appDel = UIApplication.shared.delegate as! AppDelegate
    return appDel.persistentContainer.viewContext
  }
  
  private func deleteAll<T: NSManagedObject>(type: T.Type) {
    do {
      let request = try self.context.fetch(T.fetchRequest() as! NSFetchRequest<T>)
      for result in request{
        self.context.delete(result)
      }
      try self.context.save()
    } catch {
      fatalError("DB fetch error")
    }
  }
}

extension DBService {
  
  func step1() {
    
    let todo1 = Task(context: self.context)
    todo1.name = "待辦事項1"
    todo1.details = "劃位"
    todo1.id = 1
    
    let todo2 = Task(context: self.context)
    todo2.name = "待辦事項2"
    todo2.details = "寄送行李"
    todo2.id = 2
    
    let userPassport = Passport(context: self.context)
    userPassport.expiryDate = Date()
    userPassport.number = "A00000001"
    
    let user = User(context: self.context)
    user.name = "王大明"
    user.userId = "A1234567890"
    
    user.task = NSSet(array: [todo1, todo2])
    user.passport = userPassport
    
    do {
      try self.context.save()
    } catch {
      fatalError("儲存失敗, \(error.localizedDescription)")
    }
  }
  
  func step2() {
    print("Step2--->")
    let fetchRequest = Task.fetchRequest() as NSFetchRequest<Task>
    
    do {
      let tasks = try self.context.fetch(fetchRequest)
      
      for task in tasks {
        let user = task.ofUser?.name ?? "No User Name"
        let todo = task.details ?? "No fund details"
        let passport = task.ofUser?.passport?.number ?? "No passport num"
        print("\(user)_機票號\(passport) -> \(todo)")
      }
    } catch {
      fatalError("DB save error")
    }
  }
  
  func step3() {
    print("Step3--->")
    do {
      let fetchRequestUser = User.fetchRequest() as NSFetchRequest<User>
      let users = try self.context.fetch(fetchRequestUser)
      for user in users{
        self.context.delete(user)
      }
      
      let fetchRequestTask = Task.fetchRequest() as NSFetchRequest<Task>
      let tasks = try self.context.fetch(fetchRequestTask)
      print("tasks count:\(tasks.count)")
      
      let fetchRequestPassport = Passport.fetchRequest() as NSFetchRequest<Passport>
      let passports = try self.context.fetch(fetchRequestPassport)
      print("passports count:\(passports.count)")
      
      try self.context.save()
    } catch {
      fatalError("Error:\(error.localizedDescription)")
    }
  }
  
  func deleteAll() {
    self.deleteAll(type: User.self)
    self.deleteAll(type: Task.self)
    self.deleteAll(type: Passport.self)
  }
}




extension DBService {
  
  func addMsg(user: String, text: String) {
    
    let message = Message(context: self.context)
    message.text = text
    message.user = user
    message.time = Date()
    
    self.context.insert(message)
    
    do {
      try self.context.save()
    } catch {
      fatalError("DB save error")
    }
  }
  
  var allMsgs: [Message] {
    
    let fetchRequest = Message.fetchRequest() as NSFetchRequest<Message>
    let sectionSortDescriptor = NSSortDescriptor(key: "time", ascending: false)
    fetchRequest.sortDescriptors = [sectionSortDescriptor]
    
    do {
      return try self.context.fetch(fetchRequest)
    } catch {
      fatalError("DB save error")
    }
  }
  
  var first20Msgs: [Message] {
    
    let fetchRequest = Message.fetchRequest() as NSFetchRequest<Message>
    let sectionSortDescriptor = NSSortDescriptor(key: "time", ascending: false)
    fetchRequest.sortDescriptors = [sectionSortDescriptor]
    fetchRequest.fetchLimit = 20
    
    do {
      return try self.context.fetch(fetchRequest)
    } catch {
      fatalError("DB save error")
    }
  }
}
