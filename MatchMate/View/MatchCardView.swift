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
            
            if userProfile.isAccepted == nil {
                HStack {
                    Button(action: {
                        onStatusChange(false)
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
    
                    Button(action: {
                        onStatusChange(true)
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 10)
            } else {
                Button(action: {
                    if userProfile.isAccepted == false {
                        onStatusChange(true)
                    } else {
                        onStatusChange(false)
                    }
                }) {

                    Text(userProfile.isAccepted == true ? "Accepted" : "Declined")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(width: 120, height: 40)
                        .clipped()
                        .background(Color.blue)
                }
                .disabled(userProfile.isAccepted != nil ? true : false)
                .opacity(userProfile.isAccepted  != nil ? 0.5 : 1.0)
            }
            Divider()
        }
        
    }
    
}

