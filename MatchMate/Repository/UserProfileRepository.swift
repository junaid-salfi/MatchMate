//
//  UserProfileRepository.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation
import CoreData

protocol UserProfileRepository {
    func saveUserProfile(_ profile: UserProfile, isAccepted: Bool)
    func fetchUserProfiles() -> [UserProfileEntity]
}

class UserProfileRespositoryService: UserProfileRepository {
    
    private let context: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func saveUserProfile(_ profile: UserProfile, isAccepted: Bool) {
        
        let userProfileEntity = UserProfileEntity(context: context)
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
        userProfileEntity.postcode = profile.location.postcode
        userProfileEntity.nat = profile.nat
        userProfileEntity.isAccepted = isAccepted
        
        do {
            try context.save()
        } catch {
            print("Failed to save profile: \(error)")
        }
        
    }
    
    func fetchUserProfiles() -> [UserProfileEntity] {
        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch profiles: \(error)")
            return []
        }
    }
}
