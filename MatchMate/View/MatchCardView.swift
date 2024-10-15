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
    let onStatusChange: (Bool) -> Void
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
                .foregroundColor(.black)
            Text("\(userProfile.location.city), \(userProfile.location.state)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            StatusButtonView(userProfile: userProfile, onStatusChange: onStatusChange)
            Divider()
        }
        
    }
    
}

