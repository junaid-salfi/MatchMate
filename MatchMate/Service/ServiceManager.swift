//
//  ServiceManager.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation
import Combine

class ServiceManager {
    private let url = URL(string: "https://randomuser.me/api/?results=10")!
    
    func fetchUserProfiles() -> AnyPublisher<[UserProfile], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: ApiResponseModel.self, decoder: JSONDecoder())
            .map({$0.results})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
