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
    @Published var isRefreshing: Bool = false
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private let serviceManager = ServiceManager()
    private let coreDataService = UserProfileRespositoryService()
    private let networkManager = NetworkManager()
    
    init() {
        fetchProfiles()
    }
    
    func fetchProfiles() {
        
        if !networkManager.isConnected {
            // If no internet connection
            errorMessage = "You are not connected to the internet."
            loadProfilesFromDatabase()
            return
        } else {
            serviceManager.fetchUserProfiles()
                .sink(receiveCompletion: {
                    completion in
                    if case let .failure(error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                }, receiveValue: {
                    [weak self] profiles in
                    guard let weakSelf = self else {return}
                    weakSelf.profiles = profiles
                    profiles.forEach { profile in
                        weakSelf.coreDataService.saveUserProfile(profile, isAccepted: nil)
                    }
                    weakSelf.errorMessage = nil
                    if profiles.isEmpty {
                        weakSelf.errorMessage = "No records found."
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    func loadProfilesFromDatabase() {
        let savedProfiles = coreDataService.fetchUserProfiles()
        if savedProfiles.isEmpty {
            errorMessage = "No records found."
        } else {
            errorMessage = nil
            self.profiles = savedProfiles.map{ UserProfile(from: $0) }
        }
    }
    
    
    func updateProfileStatus(at index: Int, isAccepted: Bool) {
        profiles[index].isAccepted = isAccepted
        coreDataService.saveUserProfile(profiles[index], isAccepted: isAccepted)
    }
    
    func refreshProfiles() {
        isRefreshing = true
        fetchProfiles()
        isRefreshing = false
    }
    
}
