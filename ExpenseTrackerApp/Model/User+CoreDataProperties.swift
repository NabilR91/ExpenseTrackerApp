//
//  User+CoreDataProperties.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 30.01.23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var isLoggedIn: Bool

}

extension User : Identifiable {

}
