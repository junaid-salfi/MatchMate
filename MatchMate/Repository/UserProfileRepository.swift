//
//  UserProfileRepository.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation
import CoreData

protocol UserProfileRepository {
    func saveUserProfile(_ profile: UserProfile, isAccepted: Bool?)
    func fetchUserProfiles() throws -> [UserProfileEntity]
}

class UserProfileRespositoryService: UserProfileRepository {
    
    private let context: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func saveUserProfile(_ profile: UserProfile, isAccepted: Bool?) {
        let fetchRequest: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", profile.email)
        do {
            let results = try context.fetch(fetchRequest)
            // Check if the profile already exists
            if let existingProfile = results.first {
                // Update existing profile
                existingProfile.isAccepted = isAccepted as NSNumber?
            } else {
                let userProfileEntity = UserProfileEntity(context: context)
                userProfileEntity.id = profile.id
                userProfileEntity.email = profile.email
                userProfileEntity.age = profile.dob.age
                userProfileEntity.dateOfBirth = profile.dob.date
                userProfileEntity.firstName = profile.name.first
                userProfileEntity.lastName = profile.name.last
                userProfileEntity.title = profile.name.title
                userProfileEntity.cellNumber = profile.cell
                userProfileEntity.phone = profile.phone
                userProfileEntity.city = profile.location.city
                userProfileEntity.country = profile.location.country
                userProfileEntity.state = profile.location.state
                userProfileEntity.streetName = profile.location.street.name
                userProfileEntity.streetNumber = profile.location.street.number
                userProfileEntity.pictureLarge = profile.picture.large
                userProfileEntity.pictureMedium = profile.picture.medium
                userProfileEntity.pictureThumbnail = profile.picture.thumbnail
                userProfileEntity.gender = profile.gender
                userProfileEntity.nat = profile.nat
                userProfileEntity.isAccepted = isAccepted as NSNumber?
            }
            try context.save()
        } catch {
            print("Failed to save profile: \(error)")
        }
    }
    
    func fetchUserProfiles() throws -> [UserProfileEntity] {
        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        return try context.fetch(request)
    }
}
