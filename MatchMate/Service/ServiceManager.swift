//
//  ServiceManager.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation

enum APIError: Error, LocalizedError {
    case error(String)
    var errorDescription: String? {
        switch self {
        case .error(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}

class ServiceManager {
    private let url = URL(string: "https://randomuser.me/api/?results=10")!
    private let session: URLSession = .shared
    
    func fetchUserProfiles() async throws -> [UserProfile] {
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.error("Something went wrong, please try again later.")
        }
        return try JSONDecoder().decode(ApiResponseModel.self, from: data).results
    }
}
