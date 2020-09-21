//
//  Message+CoreDataProperties.swift
//  CoreData_Example
//
//  Created by hjliu on 2020/9/21.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var user: String?
    @NSManaged public var time: Date?
    @NSManaged public var text: String?

}

extension Message : Identifiable {

}
