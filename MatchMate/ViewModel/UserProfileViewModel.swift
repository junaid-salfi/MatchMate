//
//  UserProfileViewModel.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import Foundation
import CoreData
import Combine

enum AppState {
    case loading
    case finished
    case error(String)
}

enum ErrorMessgae: String {
    case connectionError
    
    var description: String {
        switch self {
        case .connectionError:
            return "The Internet connection appears to be offline"
        }
    }
}

class UserProfileViewModel: ObservableObject {
    
    @Published var profiles: [UserProfile] = []
    @Published var state: AppState = .loading
    private let serviceManager = ServiceManager()
    private let coreDataService: UserProfileRepository
    private let networkConnectivity = NetworkConnectivity()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coreDataService: UserProfileRepository) {
        self.coreDataService = coreDataService
        trackConnectivitity()
    }
    
    @MainActor
    func fetchProfiles() {
        guard networkConnectivity.isConnected else {
            // If no internet connectio
            loadProfilesFromDatabase()
            return
        }
        
        state = .loading
        
        Task {
            do {
                let result = try await serviceManager.fetchUserProfiles()
                guard !result.isEmpty else {
                    state = .error("No Records found.")
                    return
                }
                profiles = result
                profiles.forEach { profile in
                    coreDataService.saveUserProfile(profile, isAccepted: nil)
                }
                state = .finished
            } catch {
               state = .error(error.localizedDescription)
            }
            
        }
    }
    
    func loadProfilesFromDatabase() {
        do {
            let savedProfiles = try coreDataService.fetchUserProfiles()
            guard !savedProfiles.isEmpty else {
                state = .error("No records found.")
                return
            }
            self.profiles = savedProfiles.map{ UserProfile(from: $0) }
            state = .finished
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    
    func updateProfileStatus(at index: Int, isAccepted: Bool) {
        profiles[index].isAccepted = isAccepted
        coreDataService.saveUserProfile(profiles[index], isAccepted: isAccepted)
    }
    
    private func trackConnectivitity() {
        networkConnectivity.$isConnected
            .sink { [weak self] isConnected in
                guard let weakSelf = self else {
                    return
                }
                if isConnected {
                    Task {
                        await weakSelf.fetchProfiles()
                    }
                } else {
                    weakSelf.loadProfilesFromDatabase()
                }
            }
            .store(in: &cancellables)
    }
    
}
