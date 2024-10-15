//
//  UserProfileViewModel.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation
import CoreData
import Combine

class UserProfileViewModel: ObservableObject {
    
    @Published var profiles: [UserProfile] = []
    private var cancellables = Set<AnyCancellable>()
    private let serviceManager = ServiceManager()
    private let coreDataService = UserProfileRespositoryService()
    
    init() {
        fetchProfiles()
    }
    
    func fetchProfiles() {
        let savedProfiles = coreDataService.fetchUserProfiles()
        if !savedProfiles.isEmpty {
            // Handle offline mode
            self.profiles = savedProfiles.map{ UserProfile(from: $0) }
        } else {
            serviceManager.fetchUserProfiles()
                .sink(receiveCompletion: {
                    completion in
                    if case let .failure(error) = completion {
                        print("Error fetching profiles: \(error)")
                    }
                }, receiveValue: {
                    [weak self] profiles in
                    self?.profiles = profiles
                    profiles.forEach { profile in
                        self?.coreDataService.saveUserProfile(profile, isAccepted: nil)
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    
    func updateProfileStatus(at index: Int, isAccepted: Bool) {
        profiles[index].isAccepted = isAccepted
        coreDataService.saveUserProfile(profiles[index], isAccepted: isAccepted)
    }
    
}
