//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import SwiftUI

@main
struct MatchMateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ProfileListView(viewModel: UserProfileViewModel(coreDataService: UserProfileRespositoryService()))
        }
    }
}
