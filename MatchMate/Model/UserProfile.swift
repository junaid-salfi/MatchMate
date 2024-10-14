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
}

struct NameInfo: Decodable {
    var title, first, last : String
}

struct LocationInfo: Decodable {
    var city, state, country, postcode: String
    var street: StreetInfo
    var coordinates: CoordinateInfo
    var timezone: TimeZoneInfo
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


