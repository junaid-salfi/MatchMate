//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Test on 14/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    
    let userProfile: UserProfile
    let onStatusChange: (UserProfile, Bool) -> Void
    @State private var isAccepted: Bool =  false
    
    init(userProfile: UserProfile, onStatusChange: @escaping (UserProfile, Bool) -> Void) {
        self.userProfile = userProfile
        self.onStatusChange = onStatusChange
        self.isAccepted = userProfile.isAccepted ?? false
    }
    
    var body: some View {
        
        VStack {
            WebImage(url: URL(string: userProfile.picture.large))
                .resizable()
                .frame(height: 400)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)
                .padding()
            
            Text("\(userProfile.name.first) \(userProfile.name.last), \(userProfile.dob.age) yrs")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            Text("\(userProfile.location.city), \(userProfile.location.state)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            if userProfile.isAccepted == nil {
                StatusButtonView { value in
                    onStatusChange(userProfile, value)
                    isAccepted = value
                }
            } else {
                HStack {
                    Text(isAccepted ? "Accepted" : "Declined")
                        .frame(width: 300, height: 40)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(userProfile.isAccepted  != nil ? 0.5 : 1.0)
                }
            }
        }
        
    }
    
}

