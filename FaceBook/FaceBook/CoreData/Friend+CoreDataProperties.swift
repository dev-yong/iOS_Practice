//
//  Friend+CoreDataProperties.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 29..
//  Copyright © 2017년 이광용. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImg: String?
    @NSManaged public var message: NSSet?

}

// MARK: Generated accessors for message
extension Friend {

    @objc(addMessageObject:)
    @NSManaged public func addToMessage(_ value: Message)

    @objc(removeMessageObject:)
    @NSManaged public func removeFromMessage(_ value: Message)

    @objc(addMessage:)
    @NSManaged public func addToMessage(_ values: NSSet)

    @objc(removeMessage:)
    @NSManaged public func removeFromMessage(_ values: NSSet)

}
