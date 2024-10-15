//
//  ProfileListView.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import SwiftUI

struct ProfileListView: View {
    
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    // Show error or empty state message
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        ForEach(viewModel.profiles.indices, id: \.self) { index in
                            MatchCardView(userProfile: viewModel.profiles[index]) { isAccepted in
                                viewModel.updateProfileStatus(at: index, isAccepted: isAccepted)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchProfiles()
                    }
                }
            }
            .navigationTitle("Profile Matches")
        }
        
    }
}

