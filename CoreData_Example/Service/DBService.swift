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
  
  func createTask() {
    
    let todo1 = Task(context: self.context)
    todo1.name = "行程1"
    todo1.details = "行程1: 集合"
    todo1.id = 1
    
    let todo2 = Task(context: self.context)
    todo2.name = "行程2"
    todo2.details = "行程2: 搭車"
    todo2.id = 2
    
    do {
      try self.context.save()
    } catch {
      fatalError("儲存失敗, \(error.localizedDescription)")
    }
  }
  
  func createUser(id: String, name: String) {
    
    if let old = self.fetchUser(id: id) {
      return
    }
    
    let user = User(context: self.context)
    user.name = name
    user.userId = id
    
    do {
      try self.context.save()
    } catch {
      fatalError("儲存失敗, \(error.localizedDescription)")
    }
  }
  
  
  
  
  //  func createUser(id: String, name: String) {
  //
  //    let todo1 = Task(context: self.context)
  //    todo1.name = "行程1"
  //    todo1.details = "行程1: 集合"
  //    todo1.id = 1
  //
  //    let todo2 = Task(context: self.context)
  //    todo2.name = "行程2"
  //    todo2.details = "行程2: 搭車"
  //    todo2.id = 2
  //
  //    let userPassport = Passport(context: self.context)
  //    userPassport.expiryDate = Date()
  //    userPassport.number = "A00000001"
  //
  //    let user = User(context: self.context)
  //    user.name = name
  //    user.userId = id
  //
  //    user.task = NSSet(array: [todo1, todo2])
  //    user.passport = userPassport
  //
  //    do {
  //      try self.context.save()
  //    } catch {
  //      fatalError("儲存失敗, \(error.localizedDescription)")
  //    }
  //  }
  
  func allTask() {
    
    let fetchRequest = Task.fetchRequest() as NSFetchRequest<Task>
    
    do {
      let tasks = try self.context.fetch(fetchRequest)
      
      for task in tasks {
        print("details:\(task.details ?? "No fund details")")
        print("user:\(task.ofUser?.name ?? "No first name")")
        print("passportNum:\(task.ofUser?.passport?.number ?? "No passport num")")
      }
    } catch {
      fatalError("DB save error")
    }
  }
  
  func allPassport() {
    
    let fetchRequest = Passport.fetchRequest() as NSFetchRequest<Passport>
    
    do {
      let passports = try self.context.fetch(fetchRequest)
      
      for passport in passports {
        print(passport.number)
      }
    } catch {
      fatalError("DB save error")
    }
  }
  
  func fetchUser(id: String) -> User? {
    
    let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
    fetchRequest.predicate = NSPredicate(format: "userId == \(id)")
    
    do {
      let user = try self.context.fetch(fetchRequest).first
      return user
    } catch {
      fatalError("刪除失敗, \(error.localizedDescription)")
    }
  }
  
  func deleteUser(id: String) {
    
    let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
    fetchRequest.predicate = NSPredicate(format: "userId == \(id)")
    
    do {
      let users = try self.context.fetch(fetchRequest)
      for user in users{
        self.context.delete(user)
      }
      try self.context.save()
    } catch {
      fatalError("刪除失敗, \(error.localizedDescription)")
    }
  }
  
  func deleteAll() {
    self.deleteAll(type: User.self)
    self.deleteAll(type: Task.self)
    self.deleteAll(type: Passport.self)
  }
}




extension DBService {
  
  func addMessage(user: String, text: String) {
    
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
