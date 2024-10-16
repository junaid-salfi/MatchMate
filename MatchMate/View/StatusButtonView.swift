//
//  StatusButtonView.swift
//  MatchMate
//
//  Created by Test on 15/10/24.
//

import SwiftUI


struct StatusButtonView: View {
    let action: (Bool) -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                action(false)
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            })
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()

            Button(action: {
                action(true)
            }, label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            })
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 10)
    }
}

