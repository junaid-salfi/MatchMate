//
//  ShadiProfile.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation

struct UserProfile: Decodable {
    var gender, phone, cell, email, nat: String
    var name: NameInfo
    var location: LocationInfo
    var dob: DateOfBirthInfo
    var picture: PictureInfo
    var isAccepted: Bool? = nil
    
    init(from entity: UserProfileEntity)  {
        self.gender = entity.gender ?? ""
        self.phone = entity.phone ?? ""
        self.cell = entity.cellNumber ?? ""
        self.email = entity.email ?? ""
        self.nat = entity.nat ?? ""
        self.name = NameInfo(title: entity.title ?? "", first: entity.firstName ?? "", last: entity.lastName ?? "")
        self.location = LocationInfo(
            city: entity.city ?? "",
            state: entity.state ?? "",
            country: entity.country ?? "",
            street: StreetInfo(number: Int32(entity.streetNumber), name: entity.streetName ?? "")
        )
        self.dob = DateOfBirthInfo(date: entity.dateOfBirth ?? "", age: Int32(entity.age))
        self.picture = PictureInfo(large: entity.pictureLarge ?? "", medium: entity.pictureMedium ?? "", thumbnail: entity.pictureThumbnail ?? "")
        self.isAccepted = entity.isAccepted?.boolValue
    }
}

struct NameInfo: Decodable {
    var title, first, last : String
}

struct LocationInfo: Decodable {
    var city, state, country: String
    var street: StreetInfo
    var coordinates: CoordinateInfo?
    var timezone: TimeZoneInfo?
}

struct StreetInfo: Decodable {
    var number: Int32
    var name: String
}

struct CoordinateInfo: Decodable {
    var latitude, longitude: String
}

struct TimeZoneInfo: Decodable {
    var offset, description: String
}

struct DateOfBirthInfo: Decodable {
    var date: String
    var age: Int32
}

struct PictureInfo: Decodable {
    var large, medium, thumbnail: String
}


