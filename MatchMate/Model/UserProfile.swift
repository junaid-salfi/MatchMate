//
//  ShadiProfile.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation

struct UserProfile: Decodable, Identifiable {
    var id: String
    var gender, phone, cell, email, nat: String
    var name: NameInfo
    var location: LocationInfo
    var dob: DateOfBirthInfo
    var picture: PictureInfo
    var isAccepted: Bool? = nil
    
    init(from entity: UserProfileEntity)  {
        self.id = entity.id ?? ""
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
    
    enum CodingKeys: CodingKey {
        case id
        case gender
        case phone
        case cell
        case email
        case nat
        case name
        case location
        case dob
        case picture
        case isAccepted
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.cell = try container.decode(String.self, forKey: .cell)
        self.email = try container.decode(String.self, forKey: .email)
        self.nat = try container.decode(String.self, forKey: .nat)
        self.name = try container.decode(NameInfo.self, forKey: .name)
        self.location = try container.decode(LocationInfo.self, forKey: .location)
        self.dob = try container.decode(DateOfBirthInfo.self, forKey: .dob)
        self.picture = try container.decode(PictureInfo.self, forKey: .picture)
        self.isAccepted = try container.decodeIfPresent(Bool.self, forKey: .isAccepted)
        self.id = self.email
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


