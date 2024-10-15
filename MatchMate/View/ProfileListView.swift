//
//  ProfileListView.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import SwiftUI

struct ProfileListView: View {
    @StateObject private var viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .finished:
                    profileList
                case .error(let errorMessage):
                    ContentUnavailableView(
                        errorMessage,
                        systemImage: "",
                        description: Text("Please check your connection and try again.")
                    )
                }
            }
            .refreshable {
                viewModel.fetchProfiles()
            }
            .onAppear(perform: {
                viewModel.fetchProfiles()
            })
            .navigationTitle("Profile Matches")
        }
    }
    
    @ViewBuilder private var profileList: some View {
        List {
            ForEach(viewModel.profiles) { profile in
                MatchCardView(userProfile: profile) { profile, isAccepted in
                    viewModel.update(profile: profile, isAccepted: isAccepted)
                }
            }
        }
        .listStyle(.grouped)
        .listRowSeparator(.hidden)
    }
}

