//
//  StatusButtonView.swift
//  MatchMate
//
//  Created by Test on 15/10/24.
//

import SwiftUI

struct StatusButtonView: View {
    
    let userProfile: UserProfile
    let onStatusChange: (Bool) -> Void
    var body: some View {
        
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
            Text(userProfile.isAccepted == true ? "Accepted" : "Declined")
                .frame(width: 300, height: 40)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .opacity(userProfile.isAccepted  != nil ? 0.5 : 1.0)
        }
    }
}

