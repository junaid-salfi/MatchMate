//
//  ApiResponseModel.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation

struct ApiResponseModel: Decodable {
    let results: [UserProfile]
}
