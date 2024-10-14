//
//  UserProfileEntity+CoreDataClass.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//
//

import Foundation
import CoreData

@objc(UserProfileEntity)
public class UserProfileEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfileEntity> {
        return NSFetchRequest<UserProfileEntity>(entityName: "UserProfileEntity")
    }

    @NSManaged public var gender: String?
    @NSManaged public var phone: String?
    @NSManaged public var cellNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var nat: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var title: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var postcode: String?
    @NSManaged public var state: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var age: Int32
    @NSManaged public var pictureLarge: String?
    @NSManaged public var pictureMedium: String?
    @NSManaged public var pictureThumbnail: String?
    @NSManaged public var streetName: String?
    @NSManaged public var streetNumber: Int32
    @NSManaged public var isAccepted: Bool
}
