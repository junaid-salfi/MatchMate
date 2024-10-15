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
            ScrollView {
                VStack {
                    ForEach(viewModel.profiles.indices, id: \.self) { index in
                        MatchCardView(userProfile: viewModel.profiles[index]) { isAccepted in
                            viewModel.updateProfileStatus(at: index, isAccepted: isAccepted)
                        }
                    }
                }
            }
            .navigationTitle("Profile Matches")
        }
      
    }
}

